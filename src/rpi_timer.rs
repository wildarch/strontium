#![allow(dead_code)]
use core::intrinsics::volatile_store;
use rpi_const::PERIPHERAL_BASE;

const TIMER_BASE: usize = PERIPHERAL_BASE + 0xB400;

/** @brief 0 : 16-bit counters - 1 : 23-bit counter */
const RPI_ARMTIMER_CTRL_23BIT       : u32 = (1 << 1 );

const RPI_ARMTIMER_CTRL_PRESCALE_1  : u32 = (1 << 2 );
const RPI_ARMTIMER_CTRL_PRESCALE_16 : u32 = (1 << 2 );
const RPI_ARMTIMER_CTRL_PRESCALE_256: u32 = (1 << 2 );

/** @brief 0 : Timer interrupt disabled - 1 : Timer interrupt enabled */
const RPI_ARMTIMER_CTRL_INT_ENABLE  : u32 = (1 << 5 );
const RPI_ARMTIMER_CTRL_INT_DISABLE : u32 = (1 << 5 );

/** @brief 0 : Timer disabled - 1 : Timer enabled */
const RPI_ARMTIMER_CTRL_ENABLE      : u32 = (1 << 7 );
const RPI_ARMTIMER_CTRL_DISABLE     : u32 = (1 << 7 );

#[repr(C)]
pub struct RpiTimer {
    load: u32,
    value: u32,
    control: u32,
    irq_clear: u32,
    raw_irq: u32,
    masked_irq: u32,
    reload: u32,
    predivider: u32,
    free_counter: u32
}

impl RpiTimer {
    pub fn get() -> &'static mut RpiTimer{
        unsafe {
            //transmute(TIMER_BASE as *mut RpiTimer)
            &mut *(TIMER_BASE as *mut RpiTimer)
        }
    }

    pub fn setup(&mut self) {
        //Higher is longer interval
        unsafe { volatile_store(&mut self.load, 0x10000); }

        let control =   RPI_ARMTIMER_CTRL_23BIT |
                        RPI_ARMTIMER_CTRL_ENABLE |
                        RPI_ARMTIMER_CTRL_INT_ENABLE |
                        RPI_ARMTIMER_CTRL_PRESCALE_256;
        unsafe { volatile_store(&mut self.control, control); }
    }

    pub fn clear_irq(&mut self) {
        unsafe {
            volatile_store(&mut self.irq_clear, 1);
        }
    }
}
