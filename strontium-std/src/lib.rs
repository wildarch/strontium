#![no_std]
use core::fmt;

pub trait Read {
    fn read(&mut self, buf: &mut [u8]);
}

pub trait Write {
    fn write(&mut self, buf: &[u8]);
}

impl fmt::Write for Write {
    fn write_str(&mut self, str: &str) -> fmt::Result {
        self.write(str.as_bytes());
        Ok(())
    }
}
