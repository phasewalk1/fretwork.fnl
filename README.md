# fretwork.fnl 
adorn your fennel code. 

> Advisory: This an extremely rough pre-alpha hack (not ready for use). The goal for a v1.0-1 release is to provide the following features:

## Features

### Initialize new Fennel projects
  * Metal binaries (embedded Lua runtime)
  * Chmodded binaries (lua "binaries")
  * Libraries (Luarocks rocks)
### Manage projects in `work.fnl`
  * Configure build logic
    * (Binaries): Makefile schema, bin metadata,
    * (Rocks): Rockspec
### Generate build-dependencies
  * uses `work.fnl` to either:
    * Generate a `Makefile`
      * `fretwork makerbind`
    * Generate a `rockspec`
      * `fretwork rocks`
