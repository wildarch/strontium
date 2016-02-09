#![feature(lang_items, asm, core_intrinsics)]
#![crate_type = "staticlib"]
#![no_std]

mod gpio;
use gpio::Gpio;

mod rpi_const;

mod interrupts;
pub use interrupts::*;

mod rpi_timer;
use rpi_timer::RpiTimer;

extern {
    fn _enable_interrupts();
}

#[no_mangle]
pub extern fn main(){
    setup_stack();

    IrqController::get().enable_timer();

    let mut timer = RpiTimer::get();
    timer.setup();

    unsafe { _enable_interrupts() };

    loop {
    }

}

#[no_mangle]
pub unsafe extern fn memcpy(dest: *mut u8, src: *const u8,
                            n: usize) -> *mut u8 {
    let mut i = 0;
    while i < n {
        *dest.offset(i as isize) = *src.offset(i as isize);
        i += 1;
    }
    return dest;
}

#[no_mangle]
pub extern fn abort(){
    loop {}
}

#[allow(dead_code)]
#[inline(never)]
fn wait(n : u32){
    for _ in 0..n {
        unsafe { asm!(""); }
    }
}

#[cfg(target_arch = "arm")]
#[inline(always)]
fn setup_stack(){
    unsafe { asm!("ldr sp, =0x8000"); }
}

#[cfg(target_arch = "x86_64")]
fn setup_stack(){}

#[allow(dead_code)]
fn fib(n : u8) -> u32{
    match n {
        0|1 => n as u32,
        n => return fib(n-1)+fib(n-2)
    }
}

#[lang="eh_personality"]
extern fn eh_personality() {}

#[lang="panic_fmt"]
extern fn panic_fmt() {}
