package dlib

IntBytes16 :: bit_field u16 {
    a: u8 | 8,
    b: u8 | 8,
}

IntBytes32 :: bit_field u32 {
    a: u8 | 8,
    b: u8 | 8,
    c: u8 | 8,
    d: u8 | 8,
}

IntBytes64 :: bit_field u64 {
    a: u8 | 8,
    b: u8 | 8,
    c: u8 | 8,
    d: u8 | 8,
    e: u8 | 8,
    f: u8 | 8,
    g: u8 | 8,
    h: u8 | 8,
}

to_bytes :: proc {
    u16_to_bytes,
    u32_to_bytes,
    u64_to_bytes,
}

u16_to_bytes :: proc(n: u16) -> IntBytes16 {
    bf: IntBytes16
    bf.a = u8((n & 0xFF00) >> 8)
    bf.b = u8(n)
    return bf
}

u32_to_bytes :: proc(n: u32) -> IntBytes32 {
    bf: IntBytes32
    bf.a = u8((n & 0xFF00_0000) >> 24)
    bf.b = u8((n & 0x00FF_0000) >> 16)
    bf.c = u8((n & 0x0000_FF00) >> 8)
    bf.d = u8(n)
    return bf
}

u64_to_bytes :: proc(n: u64) -> IntBytes64 {
    bf: IntBytes64
    bf.a = u8((n & 0xFF00_0000_0000_0000) >> 56)
    bf.b = u8((n & 0x00FF_0000_0000_0000) >> 48)
    bf.c = u8((n & 0x0000_FF00_0000_0000) >> 40)
    bf.d = u8((n & 0x0000_00FF_0000_0000) >> 32)
    bf.e = u8((n & 0x0000_0000_FF00_0000) >> 24)
    bf.f = u8((n & 0x0000_0000_00FF_0000) >> 16)
    bf.g = u8((n & 0x0000_0000_0000_FF00) >> 8)
    bf.h = u8(n)
    return bf
}
