use rpi_const::GPIO_BASE;

const LED_GPFSEL: isize = 1;
const LED_GPSET: isize = 7;
const LED_GPCLR: isize = 10;
const LED_GPFBIT: isize = 18;
const LED_GPIO_BIT : isize = 16;

use core::intrinsics::{volatile_load, volatile_store};

pub struct Gpio;

impl Gpio {

    pub fn ok_on(&self, on: bool){
        let offset = if on { LED_GPCLR } else { LED_GPSET };
        unsafe {
            let base = GPIO_BASE as *mut u32;
            let val = volatile_load(base.offset(LED_GPFSEL));
            volatile_store(base.offset(LED_GPFSEL), val | 1 << LED_GPFBIT);
            volatile_store(base.offset(offset), (1 << LED_GPIO_BIT));
        }
    }
}
