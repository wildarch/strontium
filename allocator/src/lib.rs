#![feature(allocator)]
#![no_std]
// The compiler needs to be instructed that this crate is an allocator in order
// to realize that when this is linked in another allocator like jemalloc should
// not be linked in
#![allocator]

// Listed below are the five allocation functions currently required by custom
// allocators. Their signatures and symbol names are not currently typechecked
// by the compiler, but this is a future extension and are required to match
// what is found below.
//
// Note that the standard `malloc` and `realloc` functions do not provide a way
// to communicate alignment so this implementation would need to be improved
// with respect to alignment in that aspect.

use core::intrinsics::copy;


static mut heap_pointer: usize = 0x10000;

#[no_mangle]
pub unsafe extern "C" fn __rust_allocate(size: usize, _align: usize) -> *mut u8 {
    let ptr = heap_pointer as *mut u8;
    heap_pointer += size;
    return ptr;
}

#[no_mangle]
pub extern "C" fn __rust_deallocate(_ptr: *mut u8, _old_size: usize, _align: usize) {
    //nop
}

#[no_mangle]
pub unsafe extern "C" fn __rust_reallocate(ptr: *mut u8, old_size: usize, size: usize,
                                align: usize) -> *mut u8 {
    //nop
    let new_ptr = __rust_allocate(size, align);
    copy(ptr, new_ptr, old_size);
    return new_ptr;
}

#[no_mangle]
pub extern "C" fn __rust_reallocate_inplace(_ptr: *mut u8, old_size: usize,
                                        _size: usize, _align: usize) -> usize {
    old_size // this api is not supported by lib
}

#[no_mangle]
pub extern "C" fn __rust_usable_size(size: usize, _align: usize) -> usize {
    size
}
