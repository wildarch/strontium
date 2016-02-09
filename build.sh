rustc --target arm-none-eabi -O --emit=obj src/kernel.rs --out-dir obj &&
arm-none-eabi-gcc -O -mfpu=vfp -march=armv6zk -mtune=arm1176jzf-s -nostdlib -ffreestanding -fno-rtti obj/kernel.o -s src/init.s  -lgcc -o elf/kernel.elf &&
arm-none-eabi-objcopy elf/kernel.elf  -O binary bin/kernel.img
