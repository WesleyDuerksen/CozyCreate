---
name: Patchouli book setup for this pack
description: How Patchouli 1.21.1-93-NeoForge loads books — architecture, file layout, and what doesn't work
type: reference
---

## How Patchouli 1.21.1-93-NeoForge loads books

Three separate loaders exist. Understanding which does what is the entire key to getting books working without a dedicated mod.

**BookRegistry / BookFolderLoader** — Scans `.minecraft/patchouli_books/<folder>/book.json` at startup to REGISTER the book. The folder name becomes the book's path; the namespace is always `patchouli`. So `patchouli_books/guide/book.json` → book ID `patchouli:guide`. The `"namespace"` field in `book.json` is silently ignored.

**BookContentExternalLoader** — Reads categories and entries from the filesystem at `patchouli_books/<folder>/en_us/` using `FileInputStream`. This is what serves content for externally-registered books. No resource pack needed.

**BookContentResourceListenerLoader** — A `SimpleJsonResourceReloadListener` registered with the CLIENT resource manager (`RegisterClientReloadListenersEvent`). Scans `assets/<namespace>/patchouli_books/` in resource packs and mod JARs. KubeJS `kubejs/data/` is a server-side datapack and is invisible to this loader.

**MessageReloadBookContents** — The server-side sync packet. It is an EMPTY ping (`StreamCodec.unit()`); it carries no book data. It just tells the client to re-run its own resource-manager scan. Putting books in KubeJS data and hoping the server syncs them does not work.

## What doesn't work

- `kubejs/data/<ns>/patchouli_books/` — server-side datapack only, client never sees it
- `resourcepacks/<pack>/data/<ns>/patchouli_books/` — user resource packs only serve `assets/` to the client resource manager
- `"namespace": "cozycreate"` in `book.json` — ignored; namespace is always `patchouli` for external books
- `"category": "welcome"` in entries — must be fully qualified: `"category": "patchouli:welcome"`

## Working layout for this pack

```
server/patchouli_books/guide/
  book.json                          ← registers the book as patchouli:guide
  en_us/
    categories/welcome.json etc.
    entries/welcome/intro.json etc.  ← "category": "patchouli:<name>"
```

Export script copies `server/patchouli_books/` → `.minecraft/patchouli_books/`.

## Give command

```
/give @p patchouli:guide_book[patchouli:book="patchouli:guide"]
```

## FTB Quests reward item

```snbt
item: {
  id: "patchouli:guide_book"
  count: 1
  components: { "patchouli:book": "patchouli:guide" }
}
```
