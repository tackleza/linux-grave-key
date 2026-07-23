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

## Refreshing from upstream

The packaged rules currently come from the upstream `xkeyboard-config` master
commit `f05f728327f30037567cb79725120a498cb0848b` (2026-07-10), seven commits
after the `xkeyboard-config-2.48` release. The authoritative repository is:

```text
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git
```

Modern upstream releases generate the installable rules from source templates.
When importing a newer snapshot, apply the customization to these upstream
source files before generating artifacts:

- Add `grp:grave_switch = +group(grave_switch):%i` beside `grp:toggle` in
  `rules/rules.in` under `! layout[any] option = symbols`.
- Add the `grp:grave_switch` option metadata to the `grp` section of
  `rules/base.xml`.
- Add the `xkb_symbols "grave_switch"` definition to `symbols/group`.

Generate both rule sets with compatibility mappings enabled:

```bash
PYTHONPATH=. python3 -m rules.generator rules --ruleset base \
  --version v2 --compat --output /tmp/base rules/rules.in
PYTHONPATH=. python3 -m rules.generator rules --ruleset evdev \
  --version v2 --compat --output /tmp/evdev rules/rules.in
perl rules/xml2lst.pl rules/base.xml > /tmp/base.lst
```

Copy `rules/base.xml` to both packaged XML files and generate both `.lst` files
from that patched XML. Do not edit only the generated `base` and `evdev` files;
the next upstream regeneration would discard the custom rule.

## Installer behavior

Keep `script.sh` usable without arguments. Its default `--auto` mode detects
`XDG_SESSION_TYPE` first, then `WAYLAND_DISPLAY`, then `DISPLAY`. Because a
Wayland session can also export `DISPLAY` for XWayland, never check `DISPLAY`
before `WAYLAND_DISPLAY`.

Wayland installs are per-user under `$XDG_CONFIG_HOME/xkb` with the standard
fallback to `$HOME/.config/xkb`, and must not use sudo. X11 installs are
system-wide under `/usr/share/X11/xkb`; when invoked as a regular user, the
script must explicitly re-run itself with `sudo -- ... --x11`. The supported
flags are `--auto`, `--wayland`, `--x11`, and `--help`.
