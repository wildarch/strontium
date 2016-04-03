use mailbox::tags::{TagBufferOffset, Tag, Property};

#[repr(C)]
pub struct PropertyTagBuffer {
    tags: [u32; 8192],
    _align: [(u64, u64); 0],    //Align the tags to a 16-bit boundary
    index: usize
}

impl PropertyTagBuffer {
    pub fn new() -> PropertyTagBuffer {
        let mut buf = PropertyTagBuffer {
            tags: [0; 8192],
            _align: [(0, 0); 0],
            index: 2
        };
        buf.tags[TagBufferOffset::Size as usize] = 12;
        buf.tags[TagBufferOffset::RequestResponse as usize] = 0;
        buf.tags[buf.index] = 0;
        return buf
    }

    fn write(&mut self, data: u32){
        self.tags[self.index] = data;
        self.index += 1;
    }

    pub fn add_tag(&mut self, prop: Property) {
        self.write(prop.tag as u32);
        self.write(prop.size as u32);
        for p in prop.params.into_iter() {
            match *p {
                Some(data) => self.write(data),
                None => {}
            }
        }
        self.index += (prop.size/4) as usize;
    }
}
