package dlib

import "base:runtime"
import "core:fmt"
import "core:os"
import "core:path/filepath"
import "core:strings"
import "core:sys/linux"

XDG_Error :: enum {
    None,
    Empty_Home_Var,
}

Error :: union #shared_nil {
    XDG_Error,
    runtime.Allocator_Error,
}

// XDG_CONFIG_HOME
// default: /home/$USER/.config
config_home :: proc() -> (dir: string, err: Error) {
    dir = os.get_env("XDG_CONFIG_HOME")

    if dir != "" {
        return
    }

    home := os.get_env("HOME")

    if home == "" {
        err = .Empty_Home_Var
        return
    }

    dir = filepath.join([]string{home, ".config"})

    return
}

// XDG_CACHE_HOME
// default: /home/$USER/.cache
cache_home :: proc() -> (dir: string, err: Error) {
    dir = os.get_env("XDG_CACHE_HOME")

    if dir != "" {
        return
    }

    home := os.get_env("HOME")

    if home == "" {
        err = .Empty_Home_Var
        return
    }

    dir = filepath.join([]string{home, ".cache"})

    return
}

// XDG_DATA_HOME
// default: /home/$USER/.local/share
data_home :: proc() -> (dir: string, err: Error) {
    dir = os.get_env("XDG_DATA_HOME")

    if dir != "" {
        return
    }

    home := os.get_env("HOME")

    if home == "" {
        err = .Empty_Home_Var
        return
    }

    dir = filepath.join([]string{home, ".local", "share"})

    return
}

// XDG_STATE_HOME
// default: /home/$USER/.local/state
state_home :: proc() -> (dir: string, err: Error) {
    dir = os.get_env("XDG_STATE_HOME")

    if dir != "" {
        return
    }

    home := os.get_env("HOME")

    if home == "" {
        err = .Empty_Home_Var
        return
    }

    dir = filepath.join([]string{home, ".local", "state"})

    return
}

// XDG_RUNTIME_DIR
// default: /run/user/$UID
runtime_dir :: proc() -> (dir: string, err: Error) {
    dir = os.get_env("XDG_RUNTIME_DIR")

    if dir != "" {
        return
    }

    uid := fmt.tprint(linux.getuid())
    dir = filepath.join([]string{"run", "user", uid})
    return
}

// XDG_DATA_DIRS
// default: [/usr/local/share, /usr/share]
data_dirs :: proc() -> (dirs: []string, err: Error) {
    dir_str := os.get_env("XDG_DATA_DIRS")

    if dir_str != "" {
        dir_list := strings.split(dir_str, ":") or_return
        dirs = make([]string, len(dir_list)) or_return
        dirs = dir_list
        return
    }

    dirs = make([]string, 2) or_return
    dirs = {"/usr/local/share", "/usr/share"}

    return
}

// XDG_CONFIG_DIRS
// default: [/etc/xdg]
config_dirs :: proc() -> (dirs: []string, err: Error) {
    dir_str := os.get_env("XDG_CONFIG_DIRS")

    if dir_str != "" {
        dir_list := strings.split(dir_str, ":") or_return
        dirs = make([]string, len(dir_list)) or_return
        dirs = dir_list
        return
    }

    dirs = make([]string, 1) or_return
    dirs[0] = "/etc/xdg"

    return
}
