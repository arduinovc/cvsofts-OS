ASM=nasm
BOOTLOADER_DIR=bootloader
KERNEL_DIR=kernel
BUILD_DIR=build
DOCS_DIR=docs/export
OSNAME=cvsOS

all: boot.bin doc printcode

boot.bin: $(BOOTLOADER_DIR)/boot.ASM
	$(ASM) $< -f bin -o $(BUILD_DIR)/$@

.PHONY: clean doc run

run:
	qemu-system-i386 $(BUILD_DIR)/boot.bin

doc: README.md
	pandoc -s --toc --toc-depth 2 $< --metadata-file docs/template/metadata.yml -t html5 --template docs/template/html.html -o $(DOCS_DIR)/$(OSNAME).html

printcode:
	sh Printcode.sh

clean:
	cd $(BUILD_DIR) && rm -f *.bin
	cd $(DOCS_DIR) && rm -f *.html && rm -f *.txt