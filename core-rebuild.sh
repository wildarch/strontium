cd ../rust
#git pull
sudo rustc --target arm-none-eabi -O -Z no-landing-pads src/libcore/lib.rs --out-dir ~/.multirust/toolchains/nightly/lib/rustlib/arm-none-eabi/lib/
