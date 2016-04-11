use core::intrinsics::copy as memcpy;
use core::mem;

extern {
    // Linker script constants
    static kernel_start: u8;
    //static text_start: u8;
    //static text_end: u8;
    static kernel_end: u8;
}

pub fn start() -> usize {
    &kernel_start as *const u8 as usize
}

pub fn end() -> usize {
    &kernel_end as *const u8 as usize
}

pub fn size() -> usize {
    end() - start()
}
