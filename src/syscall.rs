pub fn exit(code: usize) {
    println!("User program exited with code {}", code);
    ::main(0, 0, 0 as *const u8);
}
