rustc --target arm-none-eabi -O --emit=obj src/kernel.rs --out-dir obj
arm-none-eabi-gcc -O4 -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s -nostartfiles obj/kernel.o -o elf/kernel.elf
arm-none-eabi-objcopy elf/kernel.elf  -O binary bin/kernel.img
