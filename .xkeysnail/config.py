import re
from xkeysnail.transform import (
    define_modmap,
    define_keymap,
    define_multipurpose_modmap,
    with_mark,
    set_mark,
    Key, K
)
from xkeysnail.transform import *


define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
    # Key.LEFT_CTRL: Key.CAPSLOCK,
})

# noneed? at USKBD
define_multipurpose_modmap({
    Key.LEFT_META: [Key.MUHENKAN, Key.LEFT_META],
})

define_keymap(lambda wm_class: wm_class in (
    "Google-chrome", "Brave-browser", "Firefox", "albert", "TradingView"
), {
    K("M-w"): K("C-w"),
    K("M-r"): K("C-r"),
    K("M-t"): K("C-t"),
    K("M-Shift-t"): K("C-Shift-t"),
    K("M-o"): K("C-o"),
    K("M-p"): K("C-p"),
    K("M-a"): K("C-a"),
    K("M-s"): K("C-s"),
    K("M-f"): K("C-f"),
    K("M-g"): K("C-g"),
    K("M-z"): K("C-z"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
    K("M-n"): K("C-n"),
    K("M-l"): K("C-l"),
    K("M-LEFT"): K("C-LEFT"),
    K("M-RIGHT"): K("C-RIGHT"),
    K("M-LEFT_BRACE"): K("M-LEFT"),
    K("M-RIGHT_BRACE"): K("M-RIGHT"),
    K("M-Shift-LEFT"): K("C-Shift-LEFT"),
    K("M-Shift-RIGHT"): K("C-Shift-RIGHT"),
}, "Morden")

define_keymap(lambda wm_class: wm_class in ("Boostnote", "Typora", ""), {
    K("M-LEFT"): K("C-LEFT"),
    K("M-LEFT_BRACE"): K("M-LEFT"),
    K("M-RIGHT"): K("C-RIGHT"),
    K("M-RIGHT_BRACE"): K("M-RIGHT"),
    K("M-Shift-LEFT"): K("C-Shift-LEFT"),
    K("M-Shift-RIGHT"): K("C-Shift-RIGHT"),
    K("M-Shift-t"): K("C-Shift-t"),
    K("M-SLASH"): K("C-SLASH"),
    K("M-a"): K("C-a"),
    K("M-c"): K("C-c"),
    K("M-f"): K("C-f"),
    K("M-g"): K("C-g"),
    K("M-l"): K("C-l"),
    K("M-n"): K("C-n"),
    K("M-o"): K("C-o"),
    K("M-p"): K("C-p"),
    K("M-r"): K("C-r"),
    K("M-s"): K("C-s"),
    K("M-t"): K("C-t"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-x"): K("C-x"),
    K("M-z"): K("C-z"),
}, "C All of combination keys to Meta")

define_keymap(lambda wm_class: wm_class in ("Gnome-terminal"), {
    K("C-TAB"): K("C-PAGE_DOWN"),
    K("C-Shift-TAB"): K("C-PAGE_UP"),
    K("M-c"): K("C-Shift-c"),
    K("M-v"): K("C-Shift-v"),
    K("M-t"): K("C-Shift-t"),
    K("M-w"): K("C-Shift-w"),
    # K("M-f"): K("C-Shift-f"),
    K("M-g"): K("C-Shift-g"),
    K("M-h"): K("C-Shift-h"),
    K("M-j"): K("C-Shift-j"),
}, "Gnome-terminal")


define_keymap(lambda wm_class: wm_class in (
    "Slack",
), {
    K("M-w"): K("C-w"),
    K("M-a"): K("C-a"),
    K("M-s"): K("C-s"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
}, "Slack")

define_keymap(lambda wm_class: wm_class in (
    "Nautilus",
    "libreoffice-calc", "libreoffice-writer", "libreoffice-impress",
), {
    K("M-w"): K("C-w"),
    K("M-a"): K("C-a"),
    K("M-s"): K("C-s"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
}, "Nautilus-Libreoffice")

define_keymap(lambda wm_class: wm_class in ("jetbrains-idea-ce", "jetbrains-studio"), {
    K("M-f"): K("Super-f"),
    K("M-w"): K("Super-w"),
    K("M-e"): K("Super-e"),
    K("M-SLASH"): K("Super-SLASH"),
    K("M-Shift-f"): K("Super-Shift-f"),
    # K("M-a"): K("C-a"),
    # K("M-s"): K("C-s"),
    # K("M-o"): K("C-o"),
    # K("M-x"): K("C-x"),
    # K("M-c"): K("C-c"),
    # K("M-v"): K("C-v"),
}, "jetbrains")


ignores = (
    "Boostnote",
    "Emacs",
    "FocusProxy",
    "URxvt",
    "Gnome-terminal",
    "jetbrains-idea-ce",
    "jetbrains-studio"
)
define_keymap(lambda wm_class: wm_class not in ignores, {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("C-h"): with_mark(K("backspace")),
    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
    # Delete
    K("C-d"): [K("delete"), set_mark(False)],
    # Kill line
    K("C-k"): [K("Shift-end"), K("C-x"), set_mark(False)],
    # Quit
    K("M-w"): K("C-w"),
}, "Otherwise")


define_keymap(None, {
    K("C-LEFT_BRACE"): [K("C-LEFT_BRACE"), K("MUHENKAN")],
    K("M-SPACE"): K("Super-SPACE"),
    # K("SUPER"): K("Super-GRAVE"),
}, "Global")


# define_conditional_modmap(lambda wm_class: wm_class in ("FocusProxy"), {
#     Key.CAPSLOCK: Key.LEFT_CTRL,
#     Key.LEFT_CTRL: Key.CAPSLOCK,
#
#     Key.LEFT_ALT: Key.LEFT_META,
#     # Key.RIGHT_ALT: Key.RIGHT_META,
#     Key.LEFT_META: Key.LEFT_ALT,
# })
#
# define_keymap(lambda wm_class: wm_class in ("FocusProxy"), {
#     K("Super-q"): K("M-q"),
# })


