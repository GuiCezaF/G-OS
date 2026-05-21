#![no_std]
#![no_main]

use core::panic::PanicInfo;

const VGA_BUFFER: *mut u8 = 0xb8000 as *mut u8;

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    clear_screen();
    print("micro-so started!");

    loop {}
}

fn clear_screen() {
    for i in 0..(80 * 25) {
        unsafe {
            *VGA_BUFFER.add(i * 2) = b' ';
            *VGA_BUFFER.add(i * 2 + 1) = 0x0f;
        }
    }
}

fn print(text: &str) {
    let mut offset = 0;

    for byte in text.bytes() {
        unsafe {
            *VGA_BUFFER.add(offset) = byte;
            *VGA_BUFFER.add(offset + 1) = 0x0f;
        }

        offset += 2;
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
