TITLE The Assembly Maze Runner 

; =============================================================
;  PROJECT MEMBERS:
;  1. Zohaib Raheel   (01-136242-048)
;  2. Sanaullah Turab (01-136242-026)
; =============================================================

INCLUDE Irvine32.inc

.data
    ; UI MESSAGES
    strHeader   BYTE "==== MAZE RUNNER: ZOHAIB & SANAULLAH ====", 0dh, 0ah, 0
    strLevel    BYTE "Current Level: ", 0
    strScore    BYTE "Current Score: ", 0
    strTime     BYTE "Time Left: ", 0
    strWin      BYTE 0dh, 0ah, "*** CONGRATULATIONS! YOU WON! ***", 0dh, 0ah, 0
    strLoss     BYTE 0dh, 0ah, "!!! TIME UP! GAME OVER !!!", 0dh, 0ah, 0
    strFinal    BYTE "Your Final Score: ", 0
    strInst     BYTE 0dh, 0ah, "Use W/A/S/D to move. Collect '*' for points.", 0dh, 0ah, 0

    ; --- [CHANGED] QUIT PROMPT ---
    strQuitMsg  BYTE 0dh, 0ah, "------------------------", 0dh, 0ah
                BYTE "Press 'Q' to Quit...", 0dh, 0ah, 0

    ; GLOBAL VARIABLES
    currentLevel    DWORD 1
    currentScore    DWORD 500       ; Start with 500 base score
    
    ; TIMER VARIABLES
    startTime       DWORD 0
    currentTime     DWORD 0
    timeLimit       DWORD 20000     ; 20000 ms = 20 seconds
    timeLeft        DWORD 0

    ; DYNAMIC VARIABLES
    mapPtr          DWORD 0          
    rowSize         DWORD 0          
    playerPos       DWORD 0          

    
    ; LEVEL DATA
    
    ; LEVEL 1 DATA
    L1_ROW_SIZE = 12
    L1_START_POS = 13
    
    map1 BYTE "----------", 0dh, 0ah
         BYTE "|P  | *  |", 0dh, 0ah
         BYTE "| | * E  |", 0dh, 0ah
         BYTE "| * |    |", 0dh, 0ah
         BYTE "----------", 0dh, 0ah, 0

    ; LEVEL 2 DATA
    L2_ROW_SIZE = 22
    L2_START_POS = 23
    
    map2 BYTE "--------------------", 0dh, 0ah
         BYTE "|P |  *          * |", 0dh, 0ah
         BYTE "|  |--|  --------- |", 0dh, 0ah
         BYTE "|        | *   |   |", 0dh, 0ah
         BYTE "|------| | -- -- | |", 0dh, 0ah
         BYTE "| * |      |    E  |", 0dh, 0ah
         BYTE "| ----   --------- |", 0dh, 0ah
         BYTE "--------------------", 0dh, 0ah, 0

    ; LEVEL 3 DATA
    L3_ROW_SIZE = 32
    L3_START_POS = 33
    
    map3 BYTE "------------------------------", 0dh, 0ah
         BYTE "|P     | *                *  |", 0dh, 0ah
         BYTE "| -----| -------- | ---------|", 0dh, 0ah
         BYTE "| | *  | |        | |     |  |", 0dh, 0ah
         BYTE "| | -- | | ---- | | | ----|  |", 0dh, 0ah
         BYTE "| |    | | *    | |      *   |", 0dh, 0ah
         BYTE "| | -- | | ---- | | |-----|  |", 0dh, 0ah
         BYTE "|          *    |      *  |  |", 0dh, 0ah
         BYTE "|-------------------------|  |", 0dh, 0ah
         BYTE "|  E                         |", 0dh, 0ah
         BYTE "------------------------------", 0dh, 0ah, 0

.code

;---------------------------------------------------------------
; SECTION: ZOHAIB RAHEEL (01-136242-048)                        |
; DESCRIPTION: Main Loop, Movement, Scoring, Level Management  |
;---------------------------------------------------------------

main PROC
    call LoadLevel1

GameLoop:
    ; --- CHECK TIMER (Sanaullah's Feature Integration) ---
    call CheckTimeStatus
    cmp  eax, 1             ; Returns 1 if time is up
    je   TimeUpGameOver

    ; --- DRAW HUD ---
    call Clrscr
    
    mov  edx, OFFSET strHeader
    call WriteString
    
    ; Display Level
    mov  edx, OFFSET strLevel
    call WriteString
    mov  eax, currentLevel
    call WriteDec
    call Crlf

    ; Display Score
    mov  edx, OFFSET strScore
    call WriteString
    mov  eax, currentScore
    call WriteDec
    call Crlf

    ; Display Time Left (Seconds)
    mov  edx, OFFSET strTime
    call WriteString
    mov  eax, timeLeft
    mov  ebx, 1000
    xor  edx, edx
    div  ebx                 ; Convert ms to seconds
    call WriteDec
    call Crlf
    call Crlf

    ; --- RENDER MAP ---
    mov  edx, mapPtr
    call WriteString
    
    mov  edx, OFFSET strInst
    call WriteString

    ; --- INPUT HANDLING ---
    call ReadChar            
    
    or   al, 00100000b   ; Lowercase conversion
    
    cmp  al, 'w'
    je   TryMoveUp
    cmp  al, 's'
    je   TryMoveDown
    cmp  al, 'a'
    je   TryMoveLeft
    cmp  al, 'd'
    je   TryMoveRight
    cmp  al, 'q'
    je   QuitGame
    
    jmp  GameLoop

; --- MOVEMENT LOGIC (ZOHAIB) ---
TryMoveUp:
    mov  ebx, playerPos
    sub  ebx, rowSize    
    jmp  CheckCollision

TryMoveDown:
    mov  ebx, playerPos
    add  ebx, rowSize    
    jmp  CheckCollision

TryMoveLeft:
    mov  ebx, playerPos
    dec  ebx
    jmp  CheckCollision

TryMoveRight:
    mov  ebx, playerPos
    inc  ebx
    jmp  CheckCollision

; --- COLLISION & UPDATES (ZOHAIB) ---

CheckCollision:
    mov  esi, mapPtr
    mov  al, [esi + ebx] 

    ; Wall Collision
    cmp  al, '-'
    je   GameLoop
    cmp  al, '|'
    je   GameLoop

    ; Exit Collision
    cmp  al, 'E'
    je   HandleLevelWin

;--------------------------------------------------------
;  SECTION: SANAULLAH TURAB (01-136242-026)             |
;  Description: Collectible Logic ('*') -> +20 Points   |
;--------------------------------------------------------

    cmp  al, '*'
    je   CollectItem
    jmp  MakeMove

CollectItem:
    add  currentScore, 20   ; SANAULLAH: Add 20 points for eating item
    ; Fall through to MakeMove

MakeMove:
    ; Implementation: We subtract 1 point for every move made to penalize inefficiency.
    dec  currentScore 

    mov  edi, playerPos
    mov  BYTE PTR [esi + edi], ' '  
    mov  playerPos, ebx             
    mov  BYTE PTR [esi + ebx], 'P'  
    
    jmp  GameLoop

; --- LEVEL MANAGEMENT (ZOHAIB) ---
HandleLevelWin:
    ; Calculate Time Bonus before switching levels
    call CalculateTimeBonus

    cmp  currentLevel, 1
    je   SetupLevel2
    cmp  currentLevel, 2
    je   SetupLevel3
    jmp  GameWon

SetupLevel1:
    mov  currentLevel, 1
    mov  mapPtr, OFFSET map1
    mov  rowSize, L1_ROW_SIZE
    mov  playerPos, L1_START_POS
    call ResetTimer
    jmp  GameLoop

SetupLevel2:
    add  currentScore, 100       ; ZOHAIB: Level 2 Bonus
    mov  currentLevel, 2
    mov  mapPtr, OFFSET map2
    mov  rowSize, L2_ROW_SIZE
    mov  playerPos, L2_START_POS
    call ResetTimer
    jmp  GameLoop

SetupLevel3:
    add  currentScore, 200       ; ZOHAIB: Level 3 Bonus
    mov  currentLevel, 3
    mov  mapPtr, OFFSET map3
    mov  rowSize, L3_ROW_SIZE
    mov  playerPos, L3_START_POS
    call ResetTimer
    jmp  GameLoop

