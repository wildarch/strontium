
struct UartIter {};

impl Iterator for UartIter {
    type Item = u8;

    fn next(&mut self) -> Option<Self::Item> {
        Some(uart::getc())
    }
};
