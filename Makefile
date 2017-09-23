# Requires:
# * multirust w/ nightly toolchain (https://github.com/brson/multirust)
# * arm-none-eabi toolchain (https://launchpad.net/gcc-arm-embedded)
# * git w/ rust src tree (https://github.com/rust-lang/rust) NOTE: set RUST_GIT to the path containing the 'src/' directory
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

GCC_VERSION = $(shell arm-none-eabi-gcc --version | grep -o "[0-9]\.[0-9]\.[0-9]" | head -1)
GCC_LIB = -L /usr/lib/gcc/arm-none-eabi/$(GCC_VERSION) -lgcc
KERNEL_LIB = -L $(RELEASE) -l kernel
LD_LIBS = $(KERNEL_LIB) $(GCC_LIB)
LD_OPTS = --gc-sections -O -s -nostdlib

# Clean first, otherwise some files might not be updated
all: clean bin/kernel.img

bin/kernel.img: elf/kernel.elf
	mkdir -p bin/
	$(OBJCOPY) elf/kernel.elf -O binary bin/kernel.img

elf/kernel.elf: $(OBJECTS) $(STATIC_LIBS)
	mkdir -p elf/
	$(LD) $(LD_OPTS) $(OBJECTS) $(LD_LIBS) -T $(LAYOUT) -o elf/kernel.elf

obj/init.o:
	mkdir -p obj/
	$(AS) src/init.s -o obj/init.o

$(RELEASE)/libkernel.a:
	xargo build --release --target $(TARGET)

#Clean only files in the source directory
clean:
	rm -rf elf/ bin/ obj/ target/

#Clean first, so everything is up to date
run: clean bin/kernel.img
	raspbootcom /dev/ttyUSB0 bin/kernel.img
