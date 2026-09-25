---
title: '"Immutability" of systems,'
subtitle: 'and how to break them!'
author: Yvan Sraka
theme: default
---

## **`~yvan`**

<!-- Joke: this talk is about quite the opposite of what I showed this morning!
-->

Over the past years I worked mainly as a Nix(OS) consultant\footnote{I have a
company based in Brussels, Newtype SRL, you can hire me!}, and gave a lot of
talks about it\footnote{https://git.sr.ht/~yvan-sraka/nix-talks}.

You can ask me about the NLNet grant I just got to **speed up `nixpkgs`
evaluation**!

And I use Mastodon, like all the cool kids: **<https://functional.cafe/@yvan>**

<!-- Is Mastodon stills cool?

I used to be that annoying Nix person in the room (right now, I'm missing this
year NixCon to be here with objectively the best Linux community)!

But now I'm a bit past the Nix honeymoon, and so I'm maybe a bit less
enthusiastic about it, so happy to rant about it in the hallway whenever you
want ^^'

And btw, if anyone want to give me tips about getting done an NLNet grant? -->


## Back in the day, if you said _"I broke my ..."_

- **Phone**: I'd first assume it's **hardware** ...
- **Computer**: I'd first assume it's **software** ...

<!-- I'm old, I recall times where phones were dumb and we used to have one
computer per family, when you know that feature when you can "switch users"
and there's a 3d cube rotating!

Breaking a phone usually means it falls from the fifth floor balcony, breaking
your computer just means you installed the games from the mini CD-Rom in the
Kellogs or installed the Opera browser -->

There were some tradeoff between **reliability** _(achieved by simplicity)_ VS
**customizability** _(if you want to tweak it, you accepted to take the risk of
breaking it)_\footnote{Seems to be what most Linux users still assume!}

Phones and computers have now merged into the same kind of
device.\footnote{I can install apps on my iPhone 2 but I can't tweak the look of
window decorations on macOS 11...}


## Just forbid breaking from everyday operations!

We have **normal** users and **super**users\footnote{Rarely more than one.}
_(a.k.a. `root`)_.

It's a good model, right? What could go wrong?

<!-- I volunteered in some Repair Café, we were  basically helping people
removing Opera browser and Kellogs video game by installing Linux, but what was
like really happening all the time... -->


## Oh no

I clicked on a button that made Ubuntu start an `apt dist-upgrade` but I ran
out of battery\footnote{We're in a Linux world where too few people set up
hibernation.} before it finished...

<!-- Because, you just have to type the password that unlock your screen, and
woops you have the right to break everything, and Debian upgrades are like
switching to a new haircuts, you don't want to stop halfway! -->


## What if we could make the software never break?

Switching from version `A` to version `B` of the system should be **atomic**,
and **recoverable**.

<!-- Like a StarTrek haircut, do they have that in StarTrek? -->


## Just have both systems `A` and `B` on the same machine!

That's basically how *most* of those _"immutable"_ systems work!

And then you can pick the one you want at boot, and have some fallback
mechanism, etc.

<!-- You know you have at least one version that works, btw I say "most" and
not "all" because I just don't know about other mecanisms?! -->


## How do they work?

- 1. Some do real partitioning, <!-- That's what Duranium do! -->
- 2. Some rely on specific filesystem features\footnote{e.g. APFS snapshots,
  openSUSE MicroOS Btrfs, etc.})  <!-- I never used that last one -->
- 3. Some use a "store"\footnote{That's compatible with filesystems that don't
  offer Copy-on-Write!}

<!-- You have some depublication in the 2. case but if your filesystem break
(and software aren't perfect yet), you're breaking your whole system...

3. e.g. Fedora's OSTree uses hardlinks and now use composefs (that's basically a
Content-Addressed store) -->


## Enforcing "read-only" mode?

We can use the immutable bit? we can sign images? have a trusted boot sequence,
etc.

<!-- Since that's a topic I'm less into I will not talk to much about that, but
rather ... -->

_Wasn't this a talk about **NixOS**? (or Guix?)_ Yes!

## _Input-Addressed_ Store VS _Content-Addressed_ stores

- A `/nix/store` is **input-addressed**, store object _(a.k.a a derivation)_
  can only reference other store objects, all the way down! This require some
  tricks, like rewriting dynamic library paths with `patchelf`,
- **Snix** offers a Nix-compatible frontend but offers a **content-addressed**
  and so deduplication _(using Merkle-Trees\footnote{What your favorite P2P
  protocol likely use!})_, and so "trusting" binary caches would be a no
  brainer.

A Nix derivation _(because its hashes is computed from its inputs)_ is better
be realized inside a sandbox\footnote{Which should give you reproducibility for
free, nice :)}.


## No ACLs _(yet?)_ ...

Every user can ask the daemon to **add a new entry** to the store, every user
can **read the whole content** of the store, and `/nix/store` (or `/gnu/store`)
is owned by root... so:

- you shouldn't write unencrypted secrets in the store,
- you can't set the `setuid` bit to a store path!

<!-- We're populating `/run/` with the right stuffs at both on NixOS/Guix -->


## But it's still great because ...

- **Specializations!** Using generations\footnote{System "versions" that appear
  as your bootloader entries.} to have more than one "flavor" of your device!
- We don't even need a trusted binary-cache, actually we even can do a
  **full-source bootstrap**\footnote{https://guix.gnu.org/en/blog/2023/the-full-source-bootstrap-building-from-source-all-the-way-down/}!
- You can describe your whole systems in a few files, using a surprisingly nice
  configuration language for ruling all your sofwares :)

IMHO it's the best of both worlds between _"customizability"_ and _"reliability"_!


# \Huge Q/A

<!-- In the end I wasn't sure of what kind of demo I could do, or record with
asciinema ...

But I hope you like that "breaking into small parts" introduction on the topic!
-->

**Thank you!** If you want to visit Toulouse _(South of France)_ mid-November,
we're organizing a Nix & Guix devroom at **Capitol du Libre**, and the CFP is
currently opened :)
