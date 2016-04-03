pub struct Property {
    pub tag: Tag,
    pub size: u8,
    pub params: [Option<u32>; 4]
}

impl Property {
    pub fn new(tag: Tag) -> Property {
        match tag {
            Tag::GetFirmwareVersion|
            Tag::GetBoardModel|
            Tag::GetBoardRevision|
            Tag::GetBoardMacAddress|
            Tag::GetBoardSerial|
            Tag::GetArmMemory|
            Tag::GetVcMemory|
            Tag::GetDmaChannels|
            Tag::GetPhysicalSize|
            Tag::GetVirtualSize|
            Tag::GetVirtualOffset => Property {
                tag: tag,
                size: 8,
                params: [None; 4]
            },
            Tag::GetClocks|
            Tag::GetCommandLine => Property {
                tag: tag,
                size: 256,
                params: [None; 4]
            },
            Tag::GetAlphaMode|
            Tag::GetDepth|
            Tag::GetPixelOrder|
            Tag::GetPitch => Property {
                tag: tag,
                size: 4,
                params: [None; 4]
            },
            Tag::GetOverscan => Property {
                tag: tag,
                size: 16,
                params: [None; 4]
            },
            _ => {
                unreachable!();
            }
        }
    }

    pub fn with(tag: Tag, params: [Option<u32>; 4]) -> Property {
        match tag {
            Tag::AllocateBuffer|
            Tag::SetPhysicalSize|
            Tag::TestPhysicalSize|
            Tag::SetVirtualSize|
            Tag::TestVirtualOffset|
            Tag::SetVirtualOffset => Property {
                tag: tag,
                size: 8,
                params: params
            },
            Tag::SetAlphaMode|
            Tag::SetDepth => Property {
                tag: tag,
                size: 4,
                params: params
            },
            Tag::SetOverscan => Property {
                tag: tag,
                size: 4,
                params: params
            },
            _ => {
                unreachable!();
            }
        }
    }
}

pub enum Tag {
    /* Videocore */
    GetFirmwareVersion = 0x1,

    /* Hardware */
    GetBoardModel = 0x10001,
    GetBoardRevision,
    GetBoardMacAddress,
    GetBoardSerial,
    GetArmMemory,
    GetVcMemory,
    GetClocks,

    /* Config */
    GetCommandLine = 0x50001,

    /* Shared resource management */
    GetDmaChannels = 0x60001,

    /* Power */
    GetPowerState = 0x20001,
    GetTiming,
    SetPowerState = 0x28001,

    /* Clocks */
    GetClockState = 0x30001,
    SetClockState = 0x38001,
    GetClockRate = 0x30002,
    SetClockRate = 0x38002,
    GetMaxClockRate = 0x30004,
    GetMinClockRate = 0x30007,
    GetTurbo = 0x30009,
    SetTurbo = 0x38009,

    /* Voltage */
    GetVoltage = 0x30003,
    SetVoltage = 0x38003,
    GetMaxVole = 0x30005,
    GetMinVole = 0x30008,
    GetTemperature = 0x30006,
    GetMaxTemperature = 0x3000A,
    AllocateMemory = 0x3000C,
    LockMemory = 0x3000D,
    UnlockMemory = 0x3000E,
    ReleaseMemory = 0x3000F,
    ExecuteCode = 0x30010,
    GetDispmanxMemHandle = 0x30014,
    GetEdidBlock = 0x30020,

    /* Framebuffer */
    AllocateBuffer = 0x40001,
    ReleaseBuffer = 0x48001,
    BlankScreen = 0x40002,
    GetPhysicalSize = 0x40003,
    TestPhysicalSize = 0x44003,
    SetPhysicalSize = 0x48003,
    GetVirtualSize = 0x40004,
    TestVirtualSize = 0x44004,
    SetVirtualSize = 0x48004,
    GetDepth = 0x40005,
    TestDepth = 0x44005,
    SetDepth = 0x48005,
    GetPixelOrder = 0x40006,
    TestPixelOrder = 0x44006,
    SetPixelOrder = 0x48006,
    GetAlphaMode = 0x40007,
    TestAlphaMode = 0x44007,
    SetAlphaMode = 0x48007,
    GetPitch = 0x40008,
    GetVirtualOffset = 0x40009,
    TestVirtualOffset = 0x44009,
    SetVirtualOffset = 0x48009,
    GetOverscan = 0x4000A,
    TestOverscan = 0x4400A,
    SetOverscan = 0x4800A,
    GetPalette = 0x4000B,
    TestPalette = 0x4400B,
    SetPalette = 0x4800B,
    SetCursorInfo = 0x8011,
    SetCursorState = 0x8010
}

pub enum TagState {
    Request = 0,
    Response = 1
}

pub enum TagBufferOffset {
    Size = 0,
    RequestResponse = 1
}

pub enum TagOffset {
    Ident = 0,
    ValueSize = 1,
    Response = 2,
    Value = 3
}
