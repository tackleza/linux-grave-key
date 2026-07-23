# Agent context

This repository installs a custom XKB layout-switch option named
`grp:grave_switch`. The implementation is split across several files that must
stay synchronized:

- `symbols/group` defines `xkb_symbols "grave_switch"` on key `<TLDE>`.
- `rules/base` and `rules/evdev` map the option to
  `+group(grave_switch)`.
- `rules/base.xml` and `rules/evdev.xml` expose the option to desktop settings
  tools.
- `rules/base.lst` and `rules/evdev.lst` expose the option to legacy/listing
  tools.

## Common upgrade mistake

When refreshing generated rules from a newer `xkeyboard-config` release, do
not patch only the plain rule or `.lst` files. Preserve the XML option in both
`.xml` files, or desktop environments may no longer recognize the custom
option.

The multi-layout rule sections also require an explicit target group. Keep the
following mapping shape in both `rules/base` and `rules/evdev`:

```text
! layout[1] option = symbols  -> +group(grave_switch):1
! layout[2] option = symbols  -> +group(grave_switch):2
! layout[3] option = symbols  -> +group(grave_switch):3
! layout[4] option = symbols  -> +group(grave_switch):4
```

Copying the unsuffixed `+group(grave_switch)` into all four sections compiles,
but applies every include to group 1. The grave key can then switch from the
first layout while remaining an ordinary layout character in later layouts.

After changing the rules, compile at least a two-layout keymap (for example
`us,th`) with `grp:grave_switch`. The resolved symbols must include
`group(grave_switch):1` and `group(grave_switch):2`, and `<TLDE>` must resolve
to `ISO_Next_Group` in both layout groups.
