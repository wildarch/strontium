use uart;
use core::fmt;
use gpio;

#[lang="panic_fmt"]
#[allow(unused_variables)]
pub unsafe extern "C" fn panic_impl(args: fmt::Arguments, file: &'static str, line: u32) -> ! {
    uart::write("PANIC!!!");
    uart::write(file);
    println!("Line: {}", line);
    loop {}
}

#[lang="eh_personality"]
extern fn eh_personality() {}

#[no_mangle]
pub unsafe extern fn abort(){
    let gpio = gpio::Gpio::new();
    loop {
        gpio.ok_on(false);
        for _ in 0..2_000_000 {
            asm!("");
        }
        gpio.ok_on(true);
        gpio.ok_on(false);
        for _ in 0..2_000_000 {
            asm!("");
        }
    }
}

#[no_mangle]
pub unsafe extern fn __aeabi_memclr4(s: *mut u8, n: usize) -> *mut u8 {
    let mut i = 0;
    while i < n {
        asm!("");
        *s.offset(i as isize) = 0u8;
        i += 1;
    }
    return s;
}
