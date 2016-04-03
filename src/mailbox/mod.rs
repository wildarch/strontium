pub mod interface;
pub mod tags;

use rpi_const::MAILBOX_BASES;
use core::mem;
use core::intrinsics::{volatile_load, volatile_store};

#[allow(non_snake_case)]
enum Status {
    Full  = 0x80000000,
    Empty = 0x40000000,
    Level = 0x400000FF,
}

#[derive(Copy, Clone)]
pub enum Channel {
    PowerManagement = 0,
    FrameBuffer,
    VirtualUart,
    VCHIQ,
    Leds,
    Buttons,
    TouchScreen,
    Unused,
    ArmToVC,
    VCToArm,
}

#[repr(C)]
pub struct Mailbox {
    read: u32,
    _reserved: [u32; (0x90-0x80)/4 -1],
    poll: u32,
    sender: u32,
    status: u32,
    configuration: u32,
    write: u32
}

impl Mailbox{
    pub fn get(mailbox_nr: usize) -> &'static mut Mailbox{
        unsafe {
            mem::transmute(MAILBOX_BASES[mailbox_nr] as *mut Mailbox)
        }
    }

    pub fn write(&mut self, channel: Channel, value: u32){
        let value = !(0xF) & value;
        let value = channel as u32 | value;

        while self.is_full() {}
        unsafe { volatile_store(&mut self.write as *mut _, value); }
    }

    pub fn read(&mut self, channel: Channel) -> u32 {
        let mut value : u32 = !0;

        while (value & 0xF) != (channel as u32) {
            while self.is_empty() {}
            unsafe {
                value = volatile_load(self.read as *mut _);
            }
        }
        return value >> 4;

    }

    #[inline]
    fn is_full(&self) -> bool {
        self.status & Status::Full as u32 != 0
    }

    #[inline]
    fn is_empty(&self) -> bool {
        self.status & Status::Empty as u32 != 0
    }
}
