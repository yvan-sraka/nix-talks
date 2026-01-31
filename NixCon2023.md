---
title: Compiling to Nix
subtitle: \footnotesize a quick overview
author: https://functional.cafe/\@yvan
theme: default
---


## _Who?_

- **PureNix** (Nix backend for the **PureScript** programming language)\footnote{https://github.com/purenix-org/purenix}
 
- `dhall-to-nix` (output of the **Dhall** configuration language)\footnote{https://github.com/dhall-lang/dhall-haskell}
 
- Nix integration of the **Nickel** configuration language\footnote{https://github.com/nickel-lang/organist}

- ~~**Guile**~~ (while Guix relies on `nix-daemon`, AFAIK, there are no facilities to convert Guix packages to Nix packages)


## _Why?_ Types!

> _Why might someone choose not to write an expression directly in Nix?_

Writing correct and maintainable large Nix expressions is hard. Once again, types to the rescue!

E.g. There is the PoC of a `cabal2nix`\footnote{https://github.com/cdepillabout/cabal2nixWithoutIFD} clone that does not rely on IFD\footnote{Import From Derivation} written in PureScript.


## _What for?_

Can I use language _X_ to write:

- a Nix package?
- a developer shell?
- NixOS options?
- an entire NixOS configuration?
- a Flake?


## Checklist

- [ ] Can I embed a Nix expression within it?
- [ ] Can I embed it within a Nix expression?


## Checklist: **Dhall**

- [ ] Can I embed a Nix expression within it?
- [x] Can I embed it within a Nix expression?

Dhall cannot encode many common Nixpkgs/NixOS idioms, such as:

- general recursion (e.g., `pkgs.callPackages`, the overlay system, and the NixOS module system)
- weakly-typed conversions (like `builtins.listToAttrs`)
- row polymorphism (i.e., the `...` in `{ foo, bar, ... }`)


## Checklist: **PureScript**

- [x] Can I embed a Nix expression within it?
- [x] Can I embed it within a Nix expression?

PureScript allows you to import an arbitrary Nix expression as _“FFI”_. **But**, you need to ensure everything aligns with the strict type system.

PureScript offers its own ecosystem of packages (managed by `spago`) that can be harnessed to produce readable and well-organized Nix files. **But**, the generated code carries significant abstraction overhead and will always be an attribute set of what the module exposes.


## Checklist: **Nickel**

- [x] Can I embed a Nix expression within it?
- [x] Can I embed it within a Nix expression?

There is an **experimental** Nix toolkit to use nickel as a language for writing nix packages, shells and more.

**But**, AFAIU, Nickel does not compile to Nix!


## Open questions

What languages do we commit in `nixpkgs`? Nix? Bash? Nickel? etc.


# \Huge Q/A
