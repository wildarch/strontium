use mem::transmute;

const PERIPHERAL_BASE: usize = 0x20000000;
const TIMER_BASE: usize = PERIPHERAL_BASE + 0xB400;

[repr("C")]
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
    pub fn get() -> &'static RpiTimer{
        unsafe {

        }
    }
}
