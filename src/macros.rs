use core::fmt::{self, Write};
use uart;

macro_rules! println {
    ($fmt:expr) => (print!(concat!($fmt, "\n")));
    ($fmt:expr, $($arg:tt)*) => (print!(concat!($fmt, "\n"), $($arg)*));
}

macro_rules! print {
    ($($arg:tt)*) => ({
        $crate::macros::_print(format_args!($($arg)*))
    });
}

pub fn _print(args: fmt::Arguments) {
    let mut writer = UartWriter {};
    match writer.write_fmt(args) {
        Ok(()) => {},
        Err(_) => uart::write("[ERROR] Error writing to uart") //TODO Make led blink like a maniac
    }
}

struct UartWriter {}

impl fmt::Write for UartWriter {
    fn write_str(&mut self, str: &str) -> fmt::Result {
        uart::write(str);
        Ok(())
    }
}
