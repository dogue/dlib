package dlib

import "core:fmt"

// Style :: enum {
//     Reset         = 0,
//     Bold          = 1,
//     Dim           = 2,
//     Italic        = 3,
//     Underline     = 4,
//     Blink         = 5,
//     Inverse       = 7,
//     Hidden        = 8,
//     Strikethrough = 9,
// }

Style :: struct {
    set:   int,
    reset: int,
}

Bold :: Style{1, 22}
Dim :: Style{2, 22}
Italic :: Style{3, 23}
Underline :: Style{4, 24}
Blink :: Style{5, 25}
Inverse :: Style{7, 27}
Hidden :: Style{8, 28}
Strikethrough :: Style{9, 29}

style :: proc(s: string, g: Style) -> string {
    return fmt.tprintf("\x1b[%dm%s\x1b[%dm", g.set, s, g.reset)
}

bold :: proc(s: string) -> string {
    return style(s, Bold)
}

dim :: proc(s: string) -> string {
    return style(s, Dim)
}

italic :: proc(s: string) -> string {
    return style(s, Italic)
}

underline :: proc(s: string) -> string {
    return style(s, Underline)
}

blink :: proc(s: string) -> string {
    return style(s, Blink)
}

invert :: proc(s: string) -> string {
    return style(s, Inverse)
}

hide :: proc(s: string) -> string {
    return style(s, Hidden)
}

strike :: proc(s: string) -> string {
    return style(s, Strikethrough)
}
