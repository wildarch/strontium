#![feature(lang_items, asm, core_intrinsics, naked_functions)]
#![feature(collections, alloc, allocator)]
#![no_std]

extern crate rlibc;

extern crate allocator;

pub use rlibc::*;

#[macro_use]
mod macros;

mod uart;
use uart::channel::UartChannel;
mod gpio;
mod rpi_const;
mod syscall;
mod interrupts;
extern crate raspbootin;
extern crate strontium_std;
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
    fn dmb();
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

    setup_interrupt_vector_table();
    println!("Boot complete.");

    kernel_loop();
}

fn setup_interrupt_vector_table() {
    unsafe {
        println!("Setting up interrupt vector table..");
        let start = &mut vectors_start as *mut u8;
        let end = &vectors_end as *const u8;
        let size = end as usize - start as usize;

        //Dear memcpy, why for god's sake put the destination first?!?!?! (After 1.5 hours debugging)
        memcpy(0x0 as *mut u8, start, size);
        //enable_interrupts();
    };
}

fn kernel_loop() {
    println!("hi!");
    loop {
        println!("In kernel_loop");
        wait(120_000_000);

        println!("Let's load some kernels!");
        let base = 0x8000 as *mut u8;
        unsafe {
            raspbootin::download_program(&mut UartChannel, base);
        }
        let entry_fn: (fn()) = unsafe { mem::transmute(base) };
        entry_fn();
        println!("ERR: Bootloader returned!");
    }
}


fn wait(n : usize) {
    for _ in 0..n {
        unsafe { asm!(""); }
    }
}
