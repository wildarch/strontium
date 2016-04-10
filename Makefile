# Requires:
# * multirust w/ nightly toolchain (https://github.com/brson/multirust)
# * arm-none-eabi toolchain (https://launchpad.net/gcc-arm-embedded)
# * git w/ rust src tree (https://github.com/rust-lang/rust)
# * raspbootin (https://github.com/mrvn/raspbootin)

.PHONY: all clean clean-full run rlibs rust-update test

STATIC_LIBS = $(RELEASE)/libkernel.a
RLIBS = core alloc rustc_unicode collections
OBJECTS = obj/init.o
LAYOUT = strontium.ld

TARGET = arm-none-eabi
RELEASE = target/$(TARGET)/release

# toolchain must be in $PATH!
LD = $(TARGET)-ld
AS = $(TARGET)-as
OBJCOPY = $(TARGET)-objcopy
GCC = $(TARGET)-gcc

GCC_VERSION = $(shell arm-none-eabi-gcc --version | grep -o "[0-9]\.[0-9]\.[0-9]")
GCC_LIB = -L /usr/lib/gcc/arm-none-eabi/$(GCC_VERSION) -lgcc
KERNEL_LIB = -L $(RELEASE) -l kernel
LD_LIBS = $(KERNEL_LIB) $(GCC_LIB)
LD_OPTS = --gc-sections -O -s -nostdlib

REGEX_CH = \(.*
RUSTC_COMMIT_HASH = $(shell rustc --version | grep -oE "$(REGEX_CH) " | cut -c 2-10)
RUST_COMMIT_HASH = $(shell cut $(RUST_GIT)/.git/HEAD -c 1-9)

TOOLCHAIN = $(shell multirust show-override | grep -o "toolchain: .*$$"|grep -o " .*$$")
RLIBDIR = $(shell multirust show-override | grep -Eo "$$HOME.*[^']\$$")/lib/rustlib/arm-none-eabi/lib

RLIBS_QUAL = $(RLIBS:%=$(RLIBDIR)/lib%.rlib)

RUST_GIT = ../rust
RUSTC = multirust run $(TOOLCHAIN) rustc
RUSTC_OPTS = --target arm-none-eabi -O -Z no-landing-pads --out-dir $(RLIBDIR)

bin/kernel.img: elf/kernel.elf
	mkdir -p bin/
	$(OBJCOPY) elf/kernel.elf -O binary bin/kernel.img

elf/kernel.elf: $(OBJECTS) $(STATIC_LIBS)
	mkdir -p elf/
	$(LD) $(LD_OPTS) $(OBJECTS) $(LD_LIBS) -T $(LAYOUT) -o elf/kernel.elf

obj/init.o:
	mkdir -p obj/
	$(AS) src/init.s -o obj/init.o

$(RELEASE)/libkernel.a: rlibs
	cargo build --release --target $(TARGET)

all: bin/kernel.img

#Clean only files in the source directory
clean:
	rm -rf elf/ bin/ obj/ target/

#Clean everything, including rust libraries
clean-full: clean
	rm -rf $(RLIBS_QUAL)

run: bin/kernel.img
	raspbootcom /dev/ttyUSB0 bin/kernel.img

$(RLIBDIR)/%.rlib:
	$(RUSTC) $(RUSTC_OPTS) $(RUST_GIT)/src/$*/lib.rs

rlibs: rust-src-update $(RLIBS_QUAL)

rust-src-update:
ifeq ($(RUSTC_COMMIT_HASH), $(RUST_COMMIT_HASH))
	@echo "rustc version in sync with git"
else
	cd $(RUST_GIT) ; git pull ; git checkout $(RUSTC_COMMIT_HASH)
	rm -rf $(RLIBS_QUAL)
endif
