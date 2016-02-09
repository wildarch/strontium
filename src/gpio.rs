const GPIO_BASE: u32 = 0x20200000;
const LED_GPFSEL: isize = 1;
const LED_GPSET: isize = 7;
const LED_GPCLR: isize = 10;
const LED_GPFBIT: isize = 18;
const LED_GPIO_BIT : isize = 16;

use core::intrinsics::{volatile_store};

pub struct Gpio {
    addr: *mut u32
}

impl Gpio {

    pub fn new() -> Gpio {
        Gpio {
            addr: GPIO_BASE as *mut u32
        }
    }

    pub fn ok_on(&self, on: bool){
        let offset = if on { LED_GPCLR } else { LED_GPSET };
        unsafe {
            volatile_store(self.addr.offset(LED_GPFSEL), 1 << LED_GPFBIT);
            volatile_store(self.addr.offset(offset), (1 << LED_GPIO_BIT));
        }
    }
}
