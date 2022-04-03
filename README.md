# Rin's Home 🏚

> Heavily inspired from ([malob/nixpkgs](https://github.com/malob/nixpkgs)).

This is my personal configuration with [nix](https://nixos.org/) using [**flakes**](https://nixos.wiki/wiki/Flakes), [**home-manager**](https://github.com/nix-community/home-manager), & [**nix-darwin**](https://github.com/LnL7/nix-darwin) for Darwin or MacOS System.

## Structure

```console
.
├── darwin.nix (Nix Darwin configuration)
├── default.nix (Support legacy nix)
├── flake.lock
├── flake.nix (Flake configuration)
├── flake.nix.simple (Example: currently NOT USED)
├── home (home-manager)
│   ├── activation.nix (Some script and configuration when activation the home manager)
│   ├── packages.nix (list packages per user)
│   └── shells.nix (shell configuration, default Fish shell with startship)
├── nixpkgs.nix (Support legacy nix)
├── pkgs (modules for overlay in flake.nix, mostly generated by related tools like node2nix)
│   └── node-packages
│       ├── README.md
│       ├── default.nix
│       ├── node-env.nix
│       ├── node-packages.json
│       └── node-packages.nix
└── result -> /nix/store/xxxxxxx (the result when completed run nix build)

4 directories, 15 files

```

## Usage

### Prerequisite

#### **Nix**

| System                                         | Single User | Multiple User | Command                                                             |
| ---------------------------------------------- | ----------- | ------------- | ------------------------------------------------------------------- |
| **Linux**                                      | ✅          | ✅            | [Single User](#linux-single-user) • [Multi User](#linux-multi-user) |
| **Darwin** (MacOS)                             | ❌          | ✅            | [Multi User](#darwin-multi-user)                                    |
| [**More...**](https://nixos.org/download.html) |             |               |                                                                     |

##### Linux Single User

```console
sh <(curl -L https://nixos.org/nix/install) --daemon
```

##### Linux Multi User

```console
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

##### Darwin Multi User

```console
sh <(curl -L https://nixos.org/nix/install)
```

#### Enable `experimental-features`

In general installation of nix, the nix configuration is located in `~/.config/nix/nix.conf`.
You **MUST** be set the `experimental-features` before use [this configuration](https://github.com/ri7nz/nixpkgs).

```cfg
experimental-features = nix-command flakes

// (optional) for distribution cache (DON'T COPY THIS COMMENT LINE)
substituters = https://cache.nixos.org https://cache.nixos.org/ https://r17.cachix.org
```

### Setup

- Clone [this repository](https://github.com/ri7nz/nixpkgs)

```console
// with SSH

git clone git@github.com:ri7nz/nixpkgs ~/.config/nixpkgs

// OR with HTTP
git clone https://github.com/ri7nz/nixpkgs ~/.config/nixpkgs

```

- Change directory to `~/.config/nixpkgs`

```console
cd ~/.config/nixpkgs
```

- Run Build  
  command for build: `nix build .#darwinConfigurations.[NAME].system`  
  Available for `[NAME]`:
  - `RG`

```console
nix build .#darwinConfigurations.RG.system
```

- Apply from `Result`  
  command for apply the result: `./result/sw/bin/darwin-rebuild switch --flake .#[NAME]`  
  Available for `[NAME]`:
  - `RG`  
    After `Run Build` you can apply from `./result` with this command

```console
./result/sw/bin/darwin-rebuild switch --flake .#RG
```

- Done 🚀🎉

## Acknowledgement

- [**malob/nixpkgs**](https://github.com/malob/nixpkgs) ~ [malob](https://github.com/malob) Nix System configs!.
