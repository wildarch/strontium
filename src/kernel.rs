#![feature(lang_items, asm, core_intrinsics, naked_functions)]
#![feature(collections, alloc, allocator)]
#![no_std]

extern crate collections;
extern crate alloc;
extern crate rlibc;

extern crate allocator as _allocator;

pub use rlibc::*;

#[macro_use]
mod macros;

mod uart;
mod gpio;
mod rpi_const;
mod mem;
pub use mem::kernel::relocate;

mod interrupts;
pub use interrupts::*;

mod rpi_timer;
use rpi_timer::RpiTimer;

mod lang_items;
pub use lang_items::*;

extern {
    fn enable_interrupts();
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
        enable_interrupts();
     };

    log("Interrupts enabled");
    loop {}

}

fn log(s: &str){
    uart::write("[LOG] ");
    uart::writeln(s);
}

#[allow(dead_code)]
fn wait(s: u32) {
    for _ in 0..s {
        unsafe { asm!(""); }
    }
}
