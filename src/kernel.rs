#![feature(lang_items, asm, core_intrinsics)]
#![crate_type = "staticlib"]
#![no_std]
use core::intrinsics::{volatile_store, volatile_load};

const GPIO_BASE: u32 = 0x20200000;
const LED_GPFSEL: isize = 1;
const LED_GPSET: isize = 7;
const LED_GPCLR: isize = 10;
const LED_GPFBIT: isize = 18;
const LED_GPIO_BIT : isize = 16;

#[no_mangle]
pub extern fn main() {
    let gpio = GPIO_BASE as *mut u32;
    loop {
        unsafe {
            let func_sel = volatile_load(gpio.offset(LED_GPFSEL)) | (1 << LED_GPFBIT);
            volatile_store(gpio.offset(LED_GPFSEL), func_sel);

            volatile_store(gpio.offset(LED_GPCLR), (1 << LED_GPIO_BIT));

            for _ in 0..500000 {
                asm!("");
            }

            /* gpio[LED_GPSET] = (1 << LED_GPIO_BIT); */
            volatile_store(gpio.offset(LED_GPSET), (1 << LED_GPIO_BIT));

            for _ in 0..500000 {
                asm!("");
            }
        }

    }
}

#[lang="eh_personality"]
extern fn eh_personality() {}

#[lang="panic_fmt"]
extern fn panic_fmt() {}
