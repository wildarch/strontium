COMMIT_HASH=$(rustc --version | awk -F'[()]' '{print $2}' | cut -c 1-9)
TOOLCHAIN=$(multirust show-override | grep -o "toolchain: .*$"|grep -o " .*$")
LIBDIR="$(multirust show-override | grep -Eo "$HOME.*[^']\$")/lib/rustlib/arm-none-eabi/lib/"

RUSTC="sudo multirust run $TOOLCHAIN rustc"
OPTS="--target arm-none-eabi -O -Z no-landing-pads --out-dir $LIBDIR --emit obj,link"

echo "Libraries: $LIBDIR"
mkdir -p $LIBDIR
echo "Version: $COMMIT_HASH"

cd ../rust
git pull
git checkout $COMMIT_HASH

$($RUSTC $OPTS src/libcore/lib.rs)
$($RUSTC $OPTS src/liballoc/lib.rs)
$($RUSTC $OPTS src/librustc_unicode/lib.rs)
$($RUSTC $OPTS src/libcollections/lib.rs)
