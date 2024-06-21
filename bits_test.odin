//+private
package dlib

import "core:testing"

@(test)
test_intbytes_16 :: proc(t: ^testing.T) {
    n: u16 = 0xDEAD
    ib16 := to_bytes(n)

    testing.expect_value(t, ib16.a, 0xDE)
    testing.expect_value(t, ib16.b, 0xAD)
}

@(test)
test_intbytes_32 :: proc(t: ^testing.T) {
    n: u32 = 0xDEAD_BEEF
    ib32 := to_bytes(n)

    testing.expect_value(t, ib32.a, 0xDE)
    testing.expect_value(t, ib32.b, 0xAD)
    testing.expect_value(t, ib32.c, 0xBE)
    testing.expect_value(t, ib32.d, 0xEF)
}

@(test)
test_intbytes_64 :: proc(t: ^testing.T) {
    n: u64 = 0xDEAD_BABE_EA75_BEEF
    ib64 := to_bytes(n)

    testing.expect_value(t, ib64.a, 0xDE)
    testing.expect_value(t, ib64.b, 0xAD)

    testing.expect_value(t, ib64.c, 0xBA)
    testing.expect_value(t, ib64.d, 0xBE)

    testing.expect_value(t, ib64.e, 0xEA)
    testing.expect_value(t, ib64.f, 0x75)

    testing.expect_value(t, ib64.g, 0xBE)
    testing.expect_value(t, ib64.h, 0xEF)
}
