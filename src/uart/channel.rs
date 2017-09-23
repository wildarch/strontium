use strontium_std::{Read, Write};
use super::{getc, putc};
use core::fmt;

pub struct UartChannel;

impl Read for UartChannel {
    fn read(&mut self, buf: &mut [u8]) {
        for x in buf {
            *x = getc();
        }
    }
}

impl Write for UartChannel {
    fn write(&mut self, buf: &[u8]) {
        for x in buf {
            putc(*x);
        }
    }
}

impl fmt::Write for UartChannel {
    fn write_str(&mut self, str: &str) -> fmt::Result {
        self.write(str.as_bytes());
        Ok(())
    }
}
