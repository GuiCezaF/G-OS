# micro-so

micro-so is an experimental micro operating system built from scratch with the goal of learning low-level programming, computer architecture, and kernel development.

The current implementation uses NASM for the bootloader, Rust for the kernel, GNU Make for orchestration, and QEMU for execution.

## Idea

The goal is to build a minimal text-mode operating system capable of:

- Displaying output using VGA text mode
- Reading keyboard input
- Executing simple commands
- Possibly running a lightweight interpreted language in the future

## Technologies

- NASM for the bootloader and real-mode/protected-mode setup
- Rust for the kernel
- GNU Make for build orchestration
- QEMU for running the image

## Current Flow

1. BIOS loads the boot sector at `0x7C00`.
2. The boot sector loads the kernel from disk into memory.
3. The boot sector switches the CPU to 32-bit protected mode.
4. Control transfers to the kernel entry point written in assembly.
5. The assembly entry point jumps into the Rust kernel start function.
6. The Rust kernel clears the screen and prints a startup message.

## Roadmap

1. Bootloader
   - Initialize the system
   - Load the kernel into memory
   - Leave 16-bit real mode
   - Enter 32-bit protected mode
2. Kernel integration
   - Keep the kernel entry path stable
   - Prepare the Rust kernel for more subsystems
   - Expand the boot path only when needed
3. Micro kernel development
   - Basic kernel structure
   - VGA text mode output
   - Simple memory management
   - Initial driver structure
   - First major milestone: writing directly to VGA memory
4. System console
   - Create a simple text-mode shell
   - Process user input
   - Implement the main system loop
5. Keyboard input
   - Read keyboard scancodes
   - Translate input into ASCII characters
   - Integrate keyboard input into the console
6. Task execution
   - Still undefined
   - Possible directions:
     - Basic Linux-like commands
     - Embedded interpreter

## Status

The bootloader, protected-mode transition, and Rust kernel entry point are wired together. The next steps are console input, task execution, and kernel structure cleanup.
