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

/*
#[naked]
#[no_mangle]
#[inline(never)]
pub unsafe fn relocate(start_addr: *mut u8) {
    asm!("push {r4, r5, fp}":::: "volatile");
    let start = start() as *const u8;
    //Copy the kernel to the new address
    memcpy(start, start_addr, size());
    //Calculate the offset
    let offset = start_addr as usize - start as usize;
    assert_eq!(*start_addr, *start);
    //Now fix the return address and pretend like nothing happend...
    asm!("
        add LR, $0
        pop {r4, r5, fp}
        mov PC, LR
    " :: "r"(offset));
}
*/

#[no_mangle]
#[inline(never)]
pub unsafe fn relocate(start_addr: *mut u8) {
    let start = start() as *const u8;
    memcpy(start, start_addr, size());
    let start_fn: fn(a: usize) = mem::transmute(start_addr);
    start_fn(1001);
}
