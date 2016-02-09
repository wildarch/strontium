#![allow(dead_code)]

use core::mem::transmute;
use core::intrinsics::volatile_store;

use gpio::Gpio;

use rpi_const::PERIPHERAL_BASE;

use rpi_timer::RpiTimer;

const INTERRUPT_CONTROLLER_BASE : usize = PERIPHERAL_BASE + 0xB200;

const RPI_BASIC_ARM_TIMER_IRQ     : u32 = (1 << 0);
const RPI_BASIC_ARM_MAILBOX_IRQ   : u32 = (1 << 1);
const RPI_BASIC_ARM_DOORBELL_0_IRQ: u32 = (1 << 2);
const RPI_BASIC_ARM_DOORBELL_1_IRQ: u32 = (1 << 3);
const RPI_BASIC_GPU_0_HALTED_IRQ  : u32 = (1 << 4);
const RPI_BASIC_GPU_1_HALTED_IRQ  : u32 = (1 << 5);
const RPI_BASIC_ACCESS_ERROR_1_IRQ: u32 = (1 << 6);
const RPI_BASIC_ACCESS_ERROR_0_IRQ: u32 = (1 << 7);

#[repr(C)]
pub struct IrqController {
    irq_basic_pending: u32,
    irq_pending : [u32; 2],
    fiq_control: u32,
    enable_irq: [u32; 2],
    enable_basic_irq: u32,
    disable_irq: [u32; 2],
    disable_basic_irq: u32
}

impl IrqController {
    pub fn get() -> &'static mut IrqController{
        unsafe {
            transmute(INTERRUPT_CONTROLLER_BASE as *mut IrqController)
        }
    }

    pub fn enable_timer(&mut self) {
        let ptr = &mut (self.enable_basic_irq) as *mut u32;
        unsafe {
            volatile_store(ptr, RPI_BASIC_ARM_TIMER_IRQ);
        }
    }
}

// INTERRUPT HANDLERS
#[no_mangle]
pub extern fn reset_vector(){

}

#[no_mangle]
pub extern fn fast_interrupt_vector(){

}

#[no_mangle]
pub extern fn undefined_instruction_vector(){
    loop {}
}

#[no_mangle]
pub extern fn software_interrupt_vector(){

}

#[no_mangle]
pub extern fn prefetch_abort_vector(){}

#[no_mangle]
pub extern fn data_abort_vector(){}

#[no_mangle]
pub unsafe extern fn interrupt_vector_handler(){

    static mut lit: bool = false;

    RpiTimer::get().clear_irq();

    if lit {
        Gpio::new().ok_on(false);
        lit = false;
    }
    else {
        Gpio::new().ok_on(true);
        lit = true;
    }

}

//END INTERRUPT HANDLERS
