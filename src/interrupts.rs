#![allow(dead_code)]

use core::intrinsics::volatile_store;
use core::intrinsics::volatile_load;
use core::mem;

use gpio::Gpio;
use uart;
use rpi_timer::RpiTimer;

use rpi_const::PERIPHERAL_BASE;

const INTERRUPT_CONTROLLER_BASE : usize = PERIPHERAL_BASE + 0xB200;

const RPI_BASIC_ARM_TIMER_IRQ     : u32 = 1;
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
            &mut *(INTERRUPT_CONTROLLER_BASE as *mut IrqController)
        }
    }

    pub fn enable_timer(&mut self) {
        let ptr = &mut (self.enable_basic_irq) as *mut u32;
        unsafe {
            volatile_store(ptr, RPI_BASIC_ARM_TIMER_IRQ);
        }
    }
    pub fn enable_uart(&mut self) {
        let ptr = &mut self.enable_irq[1] as *mut u32;
        unsafe { volatile_store(ptr, 1 << (57-32)) };
    }

    pub fn get_pending(&mut self) -> (u32, u64) {
        unsafe {
            (self.irq_basic_pending(), self.irq_pending())
        }
    }

    unsafe fn irq_basic_pending(&self) -> u32 {
        volatile_load(&self.irq_basic_pending as *const u32)
    }

    unsafe fn irq_pending(&self) -> u64 {
        mem::transmute(volatile_load(&self.irq_pending as *const [u32;2]))
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
    panic!("Undefined instruction!");
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

    let (basic_irq, irq) = IrqController::get().get_pending();

    if irq & (1 << 57) != 0 {
        print!("{}", uart::getc_im() as char);
        uart::clear_rx();
    }
    else if basic_irq & 1 != 0 {
        RpiTimer::get().clear_irq();
        //Flip the OK LED
        if lit {
            Gpio.ok_on(false);
            lit = false;
        }
        else {
            Gpio.ok_on(true);
            lit = true;
        }
    }
    else {
        println!("Basic: {:b}, Normal: {:b}", basic_irq, irq);
    }
}
