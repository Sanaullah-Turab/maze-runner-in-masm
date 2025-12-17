# 🎮 Maze Runner - Assembly Game

A text-based maze navigation game written in x86 Assembly (MASM32) featuring multiple levels, time challenges, and a scoring system.

## 👥 Project Team

- **Zohaib Raheel** (01-136242-048)
- **Sanaullah Turab** (01-136242-026)

## 📋 Overview

Maze Runner is an interactive console-based game where players navigate through progressively difficult mazes, collecting items while racing against time. Built entirely in x86 Assembly language using the Irvine32 library, this project demonstrates low-level programming concepts including memory management, game loops, and real-time input handling.

## ✨ Features

### Core Gameplay

- **3 Progressive Levels**: Each level increases in complexity and maze size
- **Real-time Timer**: 20-second countdown for each level
- **Scoring System**:
  - Base score: 500 points
  - Collectibles: +20 points per item (\*)
  - Movement penalty: -1 point per move
  - Level completion bonuses: 100 (Level 2), 200 (Level 3)
  - Time bonus: +10 points per remaining second

### Game Mechanics

- **WASD Controls**: Intuitive movement system
- **Collision Detection**: Walls and boundaries prevent invalid moves
- **Dynamic HUD**: Real-time display of level, score, and time
- **Item Collection**: Strategic item placement for bonus points
- **Exit Goals**: Reach 'E' to advance to the next level

## 🎯 How to Play

### Controls

- `W` - Move Up
- `A` - Move Left
- `S` - Move Down
- `D` - Move Right
- `Q` - Quit Game

### Objective

1. Navigate through the maze using WASD keys
2. Collect items (\*) for bonus points (+20 each)
3. Reach the exit (E) before time runs out
4. Complete all 3 levels for maximum score
5. Maximize your score by:
   - Collecting all items
   - Using fewer moves
   - Finishing quickly for time bonuses

### Game Elements

- `P` - Player position
- `*` - Collectible items (+20 points)
- `E` - Exit to next level
- `-` and `|` - Walls (impassable)
- ` ` - Empty space (walkable)

## 🛠️ Technical Details

### Requirements

- **Assembler**: MASM32 (Microsoft Macro Assembler)
- **Library**: Irvine32.inc
- **Platform**: Windows (x86)
- **Environment**: Visual Studio or MASM32 SDK

### Code Structure

#### Zohaib Raheel's Contributions:

- Main game loop implementation
- Movement logic (WASD input handling)
- Collision detection system
- Level management and progression
- Level completion bonuses
- Game state management

#### Sanaullah Turab's Contributions:

- Timer system (20-second countdown)
- Time bonus calculation
- Collectible item logic (\*) and scoring
- Time-based game over handling
- Movement penalty system

### Memory Layout

```
Level 1: 12 bytes per row, starting position: offset 13
Level 2: 22 bytes per row, starting position: offset 23
Level 3: 32 bytes per row, starting position: offset 33
```

## 🚀 Setup & Installation

### Prerequisites

1. Install MASM32 SDK from [masm32.com](http://www.masm32.com/)
2. Ensure Irvine32 library is properly configured

### Compilation

#### Using MASM32 Command Line:

```batch
ml /c /coff code.asm
link /subsystem:console code.obj
```

#### Using Visual Studio:

1. Create a new empty project
2. Add `code.asm` to the project
3. Configure project for MASM
4. Build and run

### Running the Game

```batch
code.exe
```

## 🎮 Gameplay Tips

1. **Plan Your Route**: Survey the maze before rushing to the exit
2. **Collect Items**: Each collectible adds 20 points minus movement costs
3. **Time Management**: Balance between collecting items and finishing quickly
4. **Efficient Movement**: Every move costs 1 point, so plan wisely
5. **Time Bonus**: Finishing with 10 seconds left = +100 points!

## 📊 Scoring Breakdown

| Action            | Points                   |
| ----------------- | ------------------------ |
| Starting Score    | +500                     |
| Collect Item (\*) | +20                      |
| Each Move         | -1                       |
| Complete Level 2  | +100                     |
| Complete Level 3  | +200                     |
| Time Bonus        | +10 per second remaining |

**Maximum Possible Score**: Varies by efficiency and speed!

## 🐛 Known Issues

- Game requires Windows environment due to Irvine32 library dependencies
- Timer precision depends on system performance
- Console window must support ANSI escape sequences for proper display

## 📝 License

This is an educational project developed for university coursework.

## 🎓 Learning Outcomes

This project demonstrates:

- Low-level memory manipulation in Assembly
- Game loop architecture
- Input handling and event processing
- Timer implementation using system calls
- Collision detection algorithms
- State management in procedural programming
- Code organization in Assembly language

## 🤝 Contributing

This is a completed university project. However, feel free to fork and experiment with:

- Additional levels
- New game mechanics
- Enhanced graphics (with ANSI codes)
- Difficulty settings
- High score persistence

---

**Built with ❤️ using x86 Assembly Language**
