ASM=nasm
BOOTLOADER_DIR=bootloader
KERNEL_DIR=kernel
BUILD_DIR=build
OSNAME=cvsOS

all: boot.bin doc

boot.bin: $(BOOTLOADER_DIR)/boot.ASM
	$(ASM) $< -f bin -o $(BUILD_DIR)/$@

.PHONY: clean doc run

run:
	qemu-system-i386 $(BUILD_DIR)/boot.bin

doc: README.md
	pandoc -s --toc --toc-depth 2 $< --metadata-file template/metadata.yml -t html5 --template template/html.html -o $(BUILD_DIR)/$(OSNAME).html

clean:
	cd $(BUILD_DIR) && rm -f *.bin && rm -f *.html
