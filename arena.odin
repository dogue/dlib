package dlib

import "core:fmt"
import "core:mem"

Arena :: struct {
    buffer:    []byte,
    offset:    int,
    capacity:  int,
    auto_grow: bool,
}

arena_create :: proc(size := 1024, auto_grow := false) -> ^Arena {
    arena := new(Arena)
    arena.buffer = make([]byte, size)
    arena.auto_grow = auto_grow
    arena.capacity = len(arena.buffer)
    return arena
}

arena_destroy :: proc(arena: ^Arena) {
    delete(arena.buffer)
    free(arena)
}

arena_alloc :: proc(arena: ^Arena, size: int, alignment := 8) -> (ptr: rawptr, resized: bool) #optional_ok {
    aligned_offset := (arena.offset + alignment - 1) & ~(alignment - 1)

    if arena.offset + aligned_offset + size >= arena.capacity {
        if arena.auto_grow {
            arena_grow(arena, len(arena.buffer) * 4)
            resized = true
        } else {
            return nil, false
        }
    }

    ptr = &arena.buffer[arena.offset]
    arena.offset += aligned_offset + size
    arena.capacity = len(arena.buffer) - arena.offset
    return
}

arena_new :: proc(arena: ^Arena, $T: typeid) -> (ptr_t: ^T, resized: bool) #optional_ok {
    size := size_of(T)
    align := align_of(T)

    ptr: rawptr
    ptr, resized = arena_alloc(arena, size, align)
    ptr_t = cast(^T)ptr
    return
}

arena_make_slice :: proc(arena: ^Arena, $T: typeid/[]$E, length: int) -> (slice: T, resized: bool) #optional_ok {
    size := size_of(E) * length
    align := align_of(E)
    ptr: rawptr
    offset := arena.offset
    ptr, resized = arena_alloc(arena, size, align)
    slice = mem.slice_ptr(cast([^]E)ptr, length)
    return
}

arena_grow :: proc(arena: ^Arena, new_size := 0) {
    size := new_size
    if size == 0 {
        size = len(arena.buffer) * 2
    }
    if size < len(arena.buffer) {
        return
    }

    new_buf := make([]byte, size)
    copy(new_buf, arena.buffer)
    delete(arena.buffer)
    arena.buffer = new_buf
    arena.capacity = len(arena.buffer) - arena.offset
}
