#![feature(lang_items, asm, core_intrinsics, naked_functions)]
#![feature(collections, alloc, allocator)]
#![no_std]

extern crate collections;
extern crate alloc;
extern crate rlibc;

extern crate allocator;

pub use rlibc::*;

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

use core::mem;
use core::intrinsics::volatile_store;

extern {
    fn enable_interrupts();
    fn disable_interrupts();
    static mut vectors_start: u8;
    static vectors_end: u8;
}

#[no_mangle]
pub extern fn main(_r0: u32, _r1: u32, _atags: *const u8){

    unsafe {
        uart::init();
    }
    println!("Stack and UART initialized");

    IrqController::get().enable_timer();
    IrqController::get().enable_uart();

    let mut timer = RpiTimer::get();
    timer.setup();

    unsafe {

        println!("Setting up interrupt vector table..");
        let start = &mut vectors_start as *mut u8;
        let end = &vectors_end as *const u8;
        let size = end as usize - start as usize;

        //Dear memcpy, why for god's sake put the destination first?!?!?! (After 1.5 hours debugging)
        memcpy(0x0 as *mut u8, start, size);
        enable_interrupts();
    };
    println!("Boot complete");

    load_kernel(_r0, _r1, _atags);

    loop {
    }


}

#[allow(dead_code)]
fn load_kernel(r0 : u32, r1: u32, atags: *const u8) {
    //3 breaks to signal we're ready for a kernel
    print!("\x03\x03\x03");
    let size = uart::get_u32() as isize;
    print!("OK");
    println!("Size: {}", size);
    let base = 0x8000 as *mut u8;
    for i in 0..size {
        unsafe {
            //*base.offset(i) = uart::getc();
            volatile_store(base.offset(i), uart::getc());
        }
    }
    println!("booting..");
    let entry_fn: (fn(a: u32, b: u32, c: *const u8)) = unsafe { mem::transmute(base) };
    unsafe { disable_interrupts(); } //Interrupts need to be disabled before we jump to the loaded kernel
    entry_fn(r0, r1, atags);
    println!("entry function exited! halting...");
}
