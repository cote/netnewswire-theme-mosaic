# Mosaic for NetNewsWire

NCSA Mosaic / 1993-web themes for [NetNewsWire](https://netnewswire.com/).
Times New Roman on a soft white (or Solarized Dark) page, classic blue /
purple / red link colors, double-line rule under the feed header. No web
fonts, no icons, no JavaScript.

Two themes ship in this repo:

- **Mosaic** - light. `#f5f5f5` paper, `#121212` ink, `#0000ee` /
  `#551a8b` / `#ff0000` links.
- **Mosaic Dark** - Solarized Dark palette. `#002b36` background,
  `#93a1a1` text, `#268bd2` / `#6c71c4` / `#dc322f` links.

NetNewsWire does not auto-switch themes by system appearance - you pick
one in Preferences / Settings → Appearance → Theme.

## Install

Pre-built bundles live in `build/`. To install on macOS, double-click
`build/Mosaic.nnwtheme` (or `build/MosaicDark.nnwtheme`) and NetNewsWire
will offer to install it. On iOS / iPadOS, open the `.nnwtheme` from
Files / iCloud Drive and choose "Open in NetNewsWire."

## Build

```
./build.sh             # rebuild bundles in build/
./build.sh --install   # also copy into the local NetNewsWire macOS
                       # theme dir for instant reload
```

Each theme lives in its own directory under `src/`:

```
src/
├── Mosaic/
│   ├── Info.plist
│   ├── stylesheet.css
│   └── template.html
└── MosaicDark/
    ├── Info.plist
    ├── stylesheet.css
    └── template.html
```

`build.sh` packages each `src/<Theme>/` into `build/<Theme>.nnwtheme/`.
Adding another variant is just another directory under `src/`.

## Tweaking

Most colors live in the `:root` block at the top of each
`stylesheet.css` as CSS custom properties (`--mosaic-bg`, `--mosaic-fg`,
`--mosaic-link`, etc.). Change those and rebuild.

The body font size on iOS uses the user's NetNewsWire font-size setting
via the `[[font-size]]` template token. The article body is bumped to
`1.5em` on top of that - if it still reads too small, raise the
`.articleBody { font-size: ... }` rule.

## License

MIT.
