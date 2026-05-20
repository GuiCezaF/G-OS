# G-OS

A ideia é desenvolver um micro SO que tenha somente o console e execute tarefas basicas.

## Ideia

- Desenvolver um micro SO que execute comandos basicos como ls, ou um simples console que execute alguma linguagem (python por simplicidade ou lua por ser leve).

## Tecnologias

- Assembly x86
- C, C++ ou Rust (A definir)
- Makefiles

## Planejamento

1. Bootloader para inicializar o kernel e passar dos 16 bits para o real-mode 32 bits
2. entry point do bootloader com o kernel, chamando a função principal no codigo de mais alto nivel
  - Falta definir em qual linguagem sera isso, as opções são C, C++ e Rust.
3. Micro Kernel escrito em alguma dessas linguagem ainda não definidas.
  - Escrever no VGA é um marco muito importante.
4. Carregar um SO (somente console).
5. Ler entrada do teclado.
6. Executar tarefas basicas, não definido se serão alguns comandos linux ou executar alguma linguagem de programação interpretada.
