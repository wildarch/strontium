use rpi_const::GPIO_BASE;

const LED_GPFSEL: isize = 1;
const LED_GPSET: isize = 7;
const LED_GPCLR: isize = 10;
const LED_GPFBIT: isize = 18;
const LED_GPIO_BIT : isize = 16;

use core::intrinsics::{volatile_load, volatile_store};

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
            let val = volatile_load(self.addr.offset(LED_GPFSEL));
            volatile_store(self.addr.offset(LED_GPFSEL), val | 1 << LED_GPFBIT);
            volatile_store(self.addr.offset(offset), (1 << LED_GPIO_BIT));
        }
    }
}
