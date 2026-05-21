ASM = nasm
CARGO = cargo
OBJCOPY = objcopy
QEMU = qemu-system-i386

ASM_DIR = ./bootloader
CONFIG_DIR = ./config
BUILD_DIR = ./build
CARGO_TARGET_DIR = $(BUILD_DIR)/cargo
TARGET = $(CONFIG_DIR)/i686-custom.json
TARGET_NAME = i686-custom
LINKER_SCRIPT = $(CONFIG_DIR)/linker.ld

BOOT_SRC = $(ASM_DIR)/boot_sector.asm
BOOT_BIN = $(BUILD_DIR)/boot_sector.bin
KERNEL_ELF = $(CARGO_TARGET_DIR)/$(TARGET_NAME)/release/micro-so
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
IMAGE = $(BUILD_DIR)/boot.bin

ASM_DEPS = $(ASM_DIR)/disk_read.asm $(ASM_DIR)/gdt.asm $(ASM_DIR)/protected_mode.asm
RUST_DEPS = Cargo.toml src/main.rs $(LINKER_SCRIPT) $(TARGET)

all: $(IMAGE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(KERNEL_ELF): $(RUST_DEPS) | $(BUILD_DIR)
	CARGO_TARGET_DIR=$(CARGO_TARGET_DIR) $(CARGO) +nightly rustc \
		-Z json-target-spec \
		--target $(TARGET) \
		-Z build-std=core,compiler_builtins \
		-Z build-std-features=compiler-builtins-mem \
		--release \
		-- -C link-arg=-T$(LINKER_SCRIPT)

$(KERNEL_BIN): $(KERNEL_ELF) | $(BUILD_DIR)
	$(OBJCOPY) -O binary $< $@

$(BOOT_BIN): $(BOOT_SRC) $(ASM_DEPS) $(KERNEL_BIN) | $(BUILD_DIR)
	KERNEL_SIZE=$$(wc -c < $(KERNEL_BIN)); \
	KERNEL_SECTORS=$$(( (KERNEL_SIZE + 511) / 512 )); \
	$(ASM) -f bin -I $(ASM_DIR)/ -D KERNEL_SECTORS=$$KERNEL_SECTORS $(BOOT_SRC) -o $(BOOT_BIN)

$(IMAGE): $(BOOT_BIN) $(KERNEL_BIN) | $(BUILD_DIR)
	cp $(BOOT_BIN) $(IMAGE)
	dd if=$(KERNEL_BIN) of=$(IMAGE) bs=512 seek=1 conv=sync,notrunc

run: $(IMAGE)
	$(QEMU) -drive format=raw,file=$(IMAGE),if=floppy -boot order=a

clean:
	rm -f $(BOOT_BIN) $(KERNEL_BIN) $(IMAGE)
