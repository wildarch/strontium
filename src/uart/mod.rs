#![allow(dead_code)]

use core::intrinsics::{volatile_load, volatile_store};

use rpi_const::GPIO_BASE;
// Controls actuation of pull up/down to ALL GPIO pins.
const GPPUD: usize = (GPIO_BASE + 0x94);

// Controls actuation of pull up/down for specific GPIO pin.
const GPPUDCLK0: usize = (GPIO_BASE + 0x98);

// The base address for UART.
const UART0_BASE: usize = 0x20201000;

// The offsets for reach register for the UART.
const UART0_DR    : usize = (UART0_BASE + 0x00);
const UART0_RSRECR: usize = (UART0_BASE + 0x04);
const UART0_FR    : usize = (UART0_BASE + 0x18);
const UART0_ILPR  : usize = (UART0_BASE + 0x20);
const UART0_IBRD  : usize = (UART0_BASE + 0x24);
const UART0_FBRD  : usize = (UART0_BASE + 0x28);
const UART0_LCRH  : usize = (UART0_BASE + 0x2C);
const UART0_CR    : usize = (UART0_BASE + 0x30);
const UART0_IFLS  : usize = (UART0_BASE + 0x34);
const UART0_IMSC  : usize = (UART0_BASE + 0x38);
const UART0_RIS   : usize = (UART0_BASE + 0x3C);
const UART0_MIS   : usize = (UART0_BASE + 0x40);
const UART0_ICR   : usize = (UART0_BASE + 0x44);
const UART0_DMACR : usize = (UART0_BASE + 0x48);
const UART0_ITCR  : usize = (UART0_BASE + 0x80);
const UART0_ITIP  : usize = (UART0_BASE + 0x84);
const UART0_ITOP  : usize = (UART0_BASE + 0x88);
const UART0_TDR   : usize = (UART0_BASE + 0x8C);

#[cold]
pub unsafe fn init() {
    // Disable UART0.
    mmio_write(UART0_CR, 0x00000000);
    // Setup the GPIO pin 14 && 15.

    // Disable pull up/down for all GPIO pins & delay for 150 cycles.
    mmio_write(GPPUD, 0x00000000);
    wait(150);

    // Disable pull up/down for pin 14,15 & delay for 150 cycles.
    mmio_write(GPPUDCLK0, (1 << 14) | (1 << 15));
    wait(150);

    // Write 0 to GPPUDCLK0 to make it take effect.
    mmio_write(GPPUDCLK0, 0x00000000);

    // Clear pending interrupts.
    mmio_write(UART0_ICR, 0x7FF);

    // Set integer & fractional part of baud rate.
    // Divider = UART_CLOCK/(16 * Baud)
    // Fraction part register = (Fractional part * 64) + 0.5
    // UART_CLOCK = 3000000; Baud = 115200.

    // Divider = 3000000 / (16 * 115200) = 1.627 = ~1.
    // Fractional part register = (.627 * 64) + 0.5 = 40.6 = ~40.
    mmio_write(UART0_IBRD, 1);
    mmio_write(UART0_FBRD, 40);

    // Enable FIFO & 8 bit data transmissio (1 stop bit, no parity).
    mmio_write(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));

    // Mask all interrupts.
    mmio_write(UART0_IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) |
                           (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10));

    // Enable UART0, receive & transfer part of UART.
    mmio_write(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
}

#[inline]
unsafe fn mmio_write(addr: usize, data: u32){
    volatile_store(addr as *mut u32, data);
}

#[inline]
unsafe fn mmio_read(addr: usize) -> u32 {
    volatile_load(addr as *mut u32)
}

pub fn putc(byte: u8){
    unsafe {
        while mmio_read(UART0_FR) & (1 << 5) != 0 { }
    	mmio_write(UART0_DR, byte as u32);
    }
}

pub fn getc() -> char {
    unsafe {
        // Wait for UART to have received something.
        while mmio_read(UART0_FR) & (1 << 4) != 0 { }
        return mmio_read(UART0_DR) as u8 as char;
    }
}

pub fn write(buffer: &str){
    let bytes = buffer.as_bytes();
    for byte in bytes {
        putc(*byte);
    }
}

pub fn writeln(buffer: &str){
    write(buffer);
    putc('\n' as u8);
}

#[inline(never)]
fn wait(n : u32){
    for _ in 0..n {
        unsafe { asm!(""); }
    }
}
