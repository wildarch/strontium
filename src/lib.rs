#![feature(lang_items, asm, core_intrinsics, naked_functions, global_allocator)]
#![feature(collections)]
#![no_std]

extern crate rlibc;
pub use rlibc::*;

extern crate allocator;
use allocator::Stronthoop;

#[global_allocator]
static ALLOCATOR: Stronthoop = Stronthoop;

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
use core::intrinsics::{volatile_store, volatile_load};

extern {
    fn enable_interrupts();
    fn disable_interrupts();
    fn dmb();
    fn play_sound();
    static mut vectors_start: u8;
    static vectors_end: u8;
}

#[no_mangle]
pub extern fn main(_r0: u32, _r1: u32, _atags: *const u8){

    unsafe { play_sound(); }

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
        unsafe { play_sound(); }
        wait(120_000_000);

        println!("Let's load some kernels!");
        let mut base = 0x8000 as *mut u8;
        unsafe {
            raspbootin::download_program(&mut UartChannel, base);
        }
        let entry_fn: (fn()) = unsafe { mem::transmute(base) };
        entry_fn();
        println!("ERR: Bootloader returned!");
    }
}

/*
unsafe fn play_sound() {
    
    //println!("Playing sound!");
    const GPIO_GPFSEL4 : isize = 0x10;
    const GPIO_FSEL0_ALT0 : u32 = 0x4;
    const GPIO_FSEL5_ALT0 : u32 = 0x20000;

    // Setup audio jack for GPIO
    use rpi_const::{GPIO_BASE, PERIPHERAL_BASE};
    let base = GPIO_BASE as *mut u32;
    volatile_store(base.offset(GPIO_GPFSEL4), GPIO_FSEL0_ALT0 + GPIO_FSEL5_ALT0);

    const CM_BASE: usize = 0x101_000;
    const CM_PASSWORD: u32 = 0x5A_000_000;
    const CM_PWMDIV: isize = 0x0A4;
    const CM_ENAB: u32 = 0x10;
    const CM_SRC_OSCILLATOR: u32 = 0x01;
    const CM_PWMCTL: isize = 0x0A0;
    let cm_base = (CM_BASE + PERIPHERAL_BASE) as *mut u32;
    volatile_store(cm_base.offset(CM_PWMDIV), CM_PASSWORD + 0x2000);
    volatile_store(cm_base.offset(CM_PWMCTL), CM_PASSWORD + CM_ENAB + CM_SRC_OSCILLATOR);

    const PWM_BASE: usize = 0x20C000;
    const PWM_RNG1: isize = 0x10;
    const PWM_RNG2: isize = 0x20;
    const PWM_CTL: isize = 0x0;
    const PWM_USEF2: u32 = 0x2000;
    const PWM_PWEN2: u32 = 0x100;
    const PWM_USEF1: u32 = 0x20;
    const PWM_PWEN1: u32 = 0x1;
    const PWM_CLRF1: u32 = 0x40;
    let pwm_base = (PWM_BASE + PERIPHERAL_BASE) as *mut u32;
    volatile_store(pwm_base.offset(PWM_RNG1), 0x190);
    volatile_store(pwm_base.offset(PWM_RNG2), 0x190);

    volatile_store(pwm_base.offset(PWM_CTL), PWM_USEF2 + PWM_PWEN2 + PWM_USEF1 + PWM_PWEN1 + PWM_CLRF1);

    const PWM_FIF1 : isize = 0x18;
    const PWM_STA: isize = 0x4;
    const PWM_FULL1: u32 = 0x1;
    
    let mut a = 0;

    //println!("Peripherals initialized");
    loop {
        volatile_store(pwm_base.offset(PWM_FIF1), a);
        volatile_store(pwm_base.offset(PWM_FIF1), a);
        a = (a + 3) % 255;
        loop {
            let status = volatile_load(pwm_base.offset(PWM_STA));
            //println!("Status: {:x}", status);
            if status & PWM_FULL1 == 0 {
                break;
            }
        }
    }
}
*/

fn wait(n : usize) {
    for _ in 0..n {
        unsafe { asm!(""); }
    }
}
