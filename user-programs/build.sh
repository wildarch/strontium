#!/usr/bin/env bash
arm-none-eabi-as add_one.s -o add_one.o
arm-none-eabi-ld add_one.o -T add_one.ld -o add_one.elf
arm-none-eabi-objdump -d add_one.elf
arm-none-eabi-objcopy --output-target=binary add_one.elf add_one.bin