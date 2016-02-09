#![allow(dead_code)]

use gpio::Gpio;

pub extern fn reset_vector(){

}

pub extern fn undefined_instruction_vector(){
    loop {}
}

pub extern fn software_interrupt_vector(){
    Gpio::new().ok_on(true);
}

pub extern fn prefetch_abort_vector(){}

pub extern fn data_abort_vector(){}

pub unsafe extern fn interrupt_vector(){
    Gpio::new().ok_on(true);
}
