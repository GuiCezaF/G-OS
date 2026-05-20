# G-OS

G-OS is an experimental micro operating system built from scratch with the goal of learning low-level programming, computer architecture, and kernel development.

The project focuses on understanding how operating systems work internally, from the boot process to basic task execution in a text-based environment.

---

# Goals

* Understand the x86 boot process
* Develop a custom bootloader
* Enter 32-bit protected mode
* Create a simple micro kernel
* Implement basic hardware communication
* Build a text-mode console
* Execute basic tasks inside the system

---

# Idea

The idea behind G-OS is to create a minimal text-mode operating system capable of:

* Displaying output using VGA text mode
* Reading keyboard input
* Executing simple commands
* Possibly running a lightweight interpreted language in the future (Lua or Python)

The main purpose of this project is learning and experimentation with operating system development.

---

# Technologies

* x86 Assembly (NASM)
* C, C++ or Rust (to be decided)
* Makefiles
* QEMU

---

# Roadmap

## 1. Bootloader

* Initialize the system
* Load the kernel into memory
* Leave 16-bit real mode
* Enter 32-bit protected mode

---

## 2. Bootloader → Kernel Integration

* Create the kernel entry point
* Transfer execution from the bootloader to the kernel
* Initialize higher-level language code

### Language still undefined:

* C
* C++
* Rust

---

## 3. Micro Kernel Development

* Basic kernel structure
* VGA text mode output
* Simple memory management
* Initial driver structure

### First major milestone:

Writing directly to VGA memory.

---

## 4. System Console

* Create a simple text-mode shell
* Process user input
* Implement the main system loop

---

## 5. Keyboard Input

* Read keyboard scancodes
* Translate input into ASCII characters
* Integrate keyboard input into the console

---

## 6. Task Execution

Still undefined.

### Possible directions:

* Basic Linux-like commands

  * `ls`
  * `clear`
  * `help`
* Embedded interpreter

  * Lua
  * Python (experimental)

---

# Initial Structure

```text id="z6bz8u"
G-OS/
├── bootloader/
├── build/
├── Makefile
└── README.md
```

---

# Status

Project currently in early development and learning phase.

---

# License

MIT

