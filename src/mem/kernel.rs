use core::ops::Range;

extern {
    // Linker script constants
    static kernel_start: u8;
    static text_start: u8;
    static text_end: u8;
    static kernel_end: u8;
}

#[derive(Clone, Copy)]
pub struct KernelLocationInfo {
    start_addr: usize,
    end_addr: usize
}

impl KernelLocationInfo {
    pub fn new() -> KernelLocationInfo {
        let start = &text_start as *const u8 as usize;
        let end = &text_end as *const u8 as usize;

        KernelLocationInfo {
            start_addr: start,
            end_addr: end
        }
    }

    pub fn size(&self) -> usize {
        self.end_addr - self.start_addr
    }

    pub fn range(&self) -> Range<u8> {
        Range {
            start: kernel_start,
            end: kernel_end
        }
    }
}
