#![feature(lang_items, asm, core_intrinsics)]
#![no_std]

#[macro_use]
mod macros;

mod uart;
mod gpio;
mod rpi_const;

mod interrupts;
pub use interrupts::*;

mod rpi_timer;
use rpi_timer::RpiTimer;

mod lang_items;
pub use lang_items::*;

mod mailbox;

extern {
    fn _enable_interrupts();
}

#[no_mangle]
pub extern fn main(){

    unsafe {
        uart::init();
        uart::putc('\n' as u8); //Test UART
    }
    log("Stack and UART initialized");

    IrqController::get().enable_timer();

    let mut timer = RpiTimer::get();
    timer.setup();

    unsafe {
        _enable_interrupts();
     };

    log("Interrupts enabled");
    loop {}

}

fn log(s: &str){
    uart::write("[LOG] ");
    uart::writeln(s);
}
