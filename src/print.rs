use core::fmt::{self, Write, Error};
use uart::write;

struct UartWriter;

impl Write for UartWriter {
    fn write_str(&mut self, s: &str) -> Result<(), Error>{
        write(s);
        Ok(())
    }
}

pub fn _print(args: fmt::Arguments){
    let mut writer = UartWriter;
    match writer.write_fmt(args) {
        Ok(()) => {},
        Err(_) => write("[ERROR] in _print")
    }
}
