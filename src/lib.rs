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


unsafe fn play_sound() {
    //play_sound_init();
    
    //println!("Playing sound!");
    const GPIO_GPFSEL4 : usize = 0x10;
    const GPIO_FSEL0_ALT0 : u32 = 0x4;
    const GPIO_FSEL5_ALT0 : u32 = 0x20000;

    // Setup audio jack for GPIO
    
    use rpi_const::{GPIO_BASE, PERIPHERAL_BASE};
    
    let gpio_gpfsel4 = GPIO_BASE + GPIO_GPFSEL4;
    volatile_store(gpio_gpfsel4 as *mut u32, GPIO_FSEL0_ALT0 + GPIO_FSEL5_ALT0);

    
    const CM_BASE: usize = 0x101000;
    const CM_PASSWORD: u32 = 0x5A000000;
    const CM_PWMDIV: usize = 0xA4;
    const CM_ENAB: u32 = 0x10;
    const CM_SRC_OSCILLATOR: u32 = 0x01;
    const CM_PWMCTL: usize = 0x0A0;
    
    let div = CM_PASSWORD + 0x2000;
    let cm_pwm_div = PERIPHERAL_BASE + CM_BASE + CM_PWMDIV;
    volatile_store(cm_pwm_div as *mut u32, div);
    let cm_pwm_ctl = PERIPHERAL_BASE + CM_BASE + CM_PWMCTL;
    volatile_store(cm_pwm_ctl as *mut u32, CM_PASSWORD + CM_ENAB + CM_SRC_OSCILLATOR);
    
    const PWM_BASE: usize = 0x20C000;
    const PWM_RNG1: usize = 0x10;
    const PWM_RNG2: usize = 0x20;
    const PWM_CTL: usize = 0x0;
    const PWM_USEF2: u32 = 0x2000;
    const PWM_PWEN2: u32 = 0x100;
    const PWM_USEF1: u32 = 0x20;
    const PWM_PWEN1: u32 = 0x1;
    const PWM_CLRF1: u32 = 0x40;
    
    let pwm_base = PWM_BASE + PERIPHERAL_BASE;
    
    let pwm_rng1 = pwm_base + PWM_RNG1;
    volatile_store(pwm_rng1 as *mut u32, 0x190);
    let pwm_rng2 = pwm_base + PWM_RNG2;
    volatile_store(pwm_rng2 as *mut u32, 0x190);

    let pwm_ctl = pwm_base + PWM_CTL;
    volatile_store(pwm_ctl  as *mut u32, PWM_USEF2 + PWM_PWEN2 + PWM_USEF1 + PWM_PWEN1 + PWM_CLRF1);
    
    const PWM_FIF1 : usize = 0x18;
    const PWM_STA: usize = 0x4;
    const PWM_FULL1: u32 = 0x1;
    
    let mut a = 0;

    loop {
        let pwm_fif1 = pwm_base + PWM_FIF1;
        volatile_store(pwm_fif1 as *mut u32, a);

        a = (a + 3) % 255;
        loop {
            let pwm_sta = pwm_base + PWM_STA;
            let status = volatile_load(pwm_sta as *mut u32);
            if status & PWM_FULL1 == 0 {
                break;
            }
        }
    }
}

fn wait(n : usize) {
    for _ in 0..n {
        unsafe { asm!(""); }
    }
}
