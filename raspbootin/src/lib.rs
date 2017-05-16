#![no_std]
extern crate strontium_std;
use strontium_std::{Read, Write};
use core::fmt;
use core::slice;
use core::mem;

pub unsafe fn download_program<C: Read + Write + fmt::Write>(channel : &mut C, base: *mut u8) {
    //3 breaks to signal we're ready for a program
    channel.write(b"\x03\x03\x03");
    let mut size_buf = [0, 0, 0, 0];
    channel.read(&mut size_buf);
    let size: u32 = mem::transmute(size_buf);
    channel.write(b"OK");
	fmt::write(channel, format_args!("Size: {}", size)).unwrap();
	let mut buf: &'static mut [u8] = slice::from_raw_parts_mut(base, size as usize);
	channel.read(&mut buf);
}
