#![no_std]
#![feature(allocator_api)]
#![feature(alloc)]
#![feature(global_allocator)]

extern crate alloc;
use alloc::allocator::{Alloc, AllocErr, Layout};
use core::result::Result;

pub struct Stronthoop;

const MAX_MEM: usize = 0x20000000;

static mut HEAP_POINTER: usize = 0x10000;

unsafe impl<'a> Alloc for &'a Stronthoop {
    unsafe fn alloc(&mut self, layout: Layout) -> Result<*mut u8, AllocErr> {
        let mut ptr = HEAP_POINTER + layout.size();
        if ptr > MAX_MEM {
            return Err(AllocErr::Exhausted{request: layout})
        }
        ptr += layout.align() - (ptr % layout.align());
        Ok(ptr as *mut u8)
    }

    unsafe fn dealloc(&mut self, ptr: *mut u8, layout: Layout) {
        unimplemented!()
    }
}