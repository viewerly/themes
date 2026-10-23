# Viewerly themes

The official themes for [Viewerly](https://viewerly.io): every theme Viewerly ships with, and
Midnight, each packaged as a plugin of its own so it can be listed, installed and updated on its
own from the [plugin and theme directory](https://viewerly.io/plugins).

| Folder | Plugin id | Variants |
| --- | --- | --- |
| `viewerly` | `io.viewerly.theme.viewerly` | dark, light |
| `catppuccin` | `io.viewerly.theme.catppuccin` | Mocha (dark), Latte (light) |
| `dracula` | `io.viewerly.theme.dracula` | dark |
| `github` | `io.viewerly.theme.github` | GitHub Dark, GitHub Light |
| `gruvbox` | `io.viewerly.theme.gruvbox` | dark, light |
| `midnight` | `io.viewerly.theme.midnight` | Midnight (dark), Dawn (light), and a file icon pack |
| `nord` | `io.viewerly.theme.nord` | dark |
| `one` | `io.viewerly.theme.one` | One Dark, One Light |
| `rose-pine` | `io.viewerly.theme.rose-pine` | Rosé Pine (dark), Dawn (light) |
| `solarized` | `io.viewerly.theme.solarized` | dark, light |
| `tokyo-night` | `io.viewerly.theme.tokyo-night` | Night (dark), Day (light) |

All except Midnight are already built into Viewerly; as plugins they are the reference for
anyone making a theme, and the directory's official entries.

Themes and icon packs are data: they ask for no capabilities, run no code, are free on every
tier, and work on every client, phones included (a phone receives a computer's plugin themes from
it).

## Installing

Download a `.vplugin` from the [releases](https://github.com/viewerly/themes/releases), then
either:

- **Settings › Plugins › Install from File…** and choose it, or
- `viewerly plugin install io.viewerly.theme.nord-1.0.0.vplugin` in a terminal.

Once the themes are listed in the directory, **Settings › Appearance › Browse Themes…** finds and
installs them without a download. Then pick the theme in **Settings › Appearance** (Light theme and
Dark theme). Installing a newer version replaces the old one.

## Building

```sh
./build.sh            # every theme: dist/<id>-<version>.vplugin
./build.sh nord one   # just these folders
```

A `.vplugin` is a zip with `viewerly-plugin.toml` at its root. You can also install a folder
straight away with **Install Folder…**, which is handy while you edit one.

## Making your own theme

Copy a folder, say `viewerly/`, and change three things:

1. **The manifest**, `viewerly-plugin.toml`: an `id` of your own in reverse-DNS form under a domain
   or account you control (`io.github.yourname.theme.ember`, not `io.viewerly.*`), a `name`, a
   `version`, and `viewerly = ">=0.2"`. `[contributes] themes` lists theme files; globs like
   `themes/*.toml` are allowed, and one plugin can carry several themes. Add `icons = "icons"` to
   bring a file icon pack, as Midnight does.
2. **The theme file**, `themes/<id>.toml` (format below).
3. **Credits**: if the palette is someone else's, check its licence allows this and say so in your
   README.

Viewerly can also make a theme file for you: **Import Theme…** in Settings › Appearance (or
`viewerly theme import <file>`) reads VS Code colour themes, iTerm2, Windows Terminal, Ghostty,
kitty, Alacritty and base16 schemes, and saves a Viewerly theme file you can edit and package.

### The theme file

A theme has a `[dark]` variant, a `[light]` variant, or both. A file only has to give the colours
that make it itself (`ui.bg0`, `ui.fg`, `ui.acc` and the terminal's `ansi` in each variant): everything else is derived the way Viewerly's own palette derives it
(hairlines and fills are the foreground at low opacity, secondary text is the foreground faded,
panels step away from the window background). Colours are `#rrggbb` or `#rrggbbaa`.

```toml
id = "ember"            # stable: Viewerly remembers the choice by it
name = "Ember"

[dark]
name = "Ember Night"    # optional: the variant's own name in the picker

[dark.ui]               # the window; bg0, fg and acc are required
bg0 = "#1a1412"         # window background
bg1 = "#15100e"         # sidebar and panels
bg2 = "#241c19"         # raised surfaces
fg = "#f2e6df"          # text
acc = "#ff8a4c"         # accent: selection, links, focus
# also: line, line2, fg2, fg3, acc_bg, sel, hover, btn, field, perm_bg

[dark.status]           # session statuses, from acc and the ANSI colours when left out
working = "#c792ea"
permission = "#ff8a4c"
input = "#ffcb6b"
done = "#9ece6a"
error = "#f7768e"
# also: idle

[dark.terminal]         # ansi is required; background and foreground default to bg0 and fg
cursor = "#ff8a4c"
selection = "#3a2c27"
ansi = ["#2a211e", "#f7768e", "#9ece6a", "#ffcb6b", "#82aaff", "#c792ea", "#89ddff", "#f2e6df"]
# 16 colours, or 8 and the bright half repeats them

[dark.syntax]           # the editor; derived from the terminal colours when left out
keyword = "#c792ea"
string = "#9ece6a"
comment = "#7a6a63"
function = "#82aaff"
type = "#ffcb6b"
# also: number, constant, variable

[light]
# the same tables under light.*
```

Status colours matter most: a theme that hides "Waiting for permission" hides the product, so
Viewerly moves a status colour that is too close to the background and the picker says it did.
The files in this repository are complete examples of every part of the format.

### Icon packs

An icon pack is a folder of `.svg` or `.png` files named for what they show: `folder.svg`,
`file.svg`, and `ext.<extension>.svg` for a file type (`ext.rs.svg`, `ext.md.svg`). See
`midnight/icons/`. Each icon is at most 256 KB. People choose it in Settings › General › File
icons.

## Submitting to the directory

1. Put your theme in a public repository with a README and a licence.
2. Build it and attach the `.vplugin` to a GitHub release (`.github/workflows/release.yml` here
   does that on every `v*` tag; copy it).
3. Submit the repository and the release file's URL at
   [viewerly.io/plugins/submit](https://viewerly.io/plugins/submit). Staff check the file (the
   same checks as installing it) and the [policy](https://viewerly.io/plugins/policy), then list
   it as a **Community** entry. Each new version is submitted the same way.

## Credits

Every palette here is used under its own MIT licence; thank you to their authors.

- **Catppuccin**: © Catppuccin, MIT. https://github.com/catppuccin/catppuccin
- **Dracula**: © Dracula Theme, MIT. https://github.com/dracula/dracula-theme
- **GitHub**: © GitHub, Inc., MIT (GitHub's VS Code theme). https://github.com/primer/github-vscode-theme
- **Gruvbox**: © Pavel Pertsev (morhetz), MIT. https://github.com/morhetz/gruvbox
- **Nord**: © Arctic Ice Studio and Sven Greb, MIT. https://github.com/nordtheme/nord
- **One Dark and One Light**: © GitHub, Inc. (Atom), MIT. https://github.com/atom/atom/tree/master/packages/one-dark-syntax
- **Rosé Pine**: © Rosé Pine, MIT. https://github.com/rose-pine/rose-pine-theme
- **Solarized**: © Ethan Schoonover, MIT. https://github.com/altercation/solarized
- **Tokyo Night**: © enkia, MIT. https://github.com/enkia/tokyo-night-vscode-theme
- **Viewerly** and **Midnight** (theme and icons): © Viewerly, MIT.

## Licence

MIT, © 2026 Viewerly. See [LICENSE](LICENSE). The palettes are their authors', under the licences
above.
