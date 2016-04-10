cargo build --release --target arm-none-eabi
arm-none-eabi-as -o obj/init.o src/init.s
arm-none-eabi-ld --gc-sections -O  -nostdlib obj/init.o -L target/arm-none-eabi/release -l kernel -s -L /usr/lib/gcc/arm-none-eabi/5.2.1/armv6-m -lgcc -o elf/kernel.elf -T strontium.ld &&
arm-none-eabi-objcopy elf/kernel.elf  -O binary bin/kernel.img
