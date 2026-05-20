ASM=nasm
QEMU=qemu-system-i386

SRC=./bootloader/boot.asm
BIN=./build/boot.bin

all: $(BIN)

$(BIN): $(SRC)
	$(ASM) -f bin $(SRC) -o $(BIN)

run: $(BIN)
	$(QEMU) -drive format=raw,file=$(BIN)

clean:
	rm -f $(BIN)
