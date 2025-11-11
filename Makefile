ASM=nasm
BOOTLOADER_DIR=bootloader
KERNEL_DIR=kernel
BUILD_DIR=build
DOCS_DIR=docs
OSNAME=cvsOS
EMULATOR_BIN=qemu-system-i386
EMULATOR_OPT=-net none


all: boot.bin doc printcode

boot.bin: $(BOOTLOADER_DIR)/boot.ASM
	$(ASM) $< -f bin -o $(BUILD_DIR)/$@

.PHONY: clean doc run printcode

run: boot.bin
	$(EMULATOR_BIN) $(EMULATOR_OPT) $(BUILD_DIR)/$<

doc: README.md
	pandoc -s --toc --toc-depth 2 $< --metadata-file $(DOCS_DIR)/template/metadata.yml -t html5 --template $(DOCS_DIR)/template/html.html -o $(BUILD_DIR)/docs/$(OSNAME).html

printcode: 
	cd $(DOCS_DIR)/scripts && sh printcode.sh

clean:
	cd $(BUILD_DIR) && rm -f *.bin
	cd $(BUILD_DIR)/docs && rm -f *.html && rm -f *.txt