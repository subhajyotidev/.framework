# framework

<p align="center">
  <strong>A declarative Linux environment, built with intention.</strong>
  <br/>
  <sub>NixOS · Flake-parts · Home Manager · Dendritic Architecture</sub>
</p>

---

> Not just a configuration. A system that evolves with the way I work.

`framework` is my personal NixOS configuration repository. It defines the
operating system, desktop environment, applications, development tools, and
everyday workflow through a modular, declarative setup.

Built around Nix flakes and a Dendritic module architecture, the goal is simple:
keep everything organized, reproducible, understandable, and easy to evolve.

## Philosophy

- **Declarative first** — define the desired system instead of manually
  maintaining it.
- **Modular by design** — separate functionality into independent, composable
  modules.
- **Reproducible** — pin dependencies and manage the environment through Nix.
- **Intentional customization** — every tool, service, and component has a
  purpose.
- **Continuous refinement** — experiment, improve, rebuild, repeat.

## Architecture

The repository follows a Dendritic architecture built with `flake-parts` and
`import-tree`.

Rather than maintaining a large collection of interconnected configuration
files, functionality is divided into focused modules and grouped by
responsibility.

```text
framework/
│
├── flake.nix
├── flake.lock
├── hardware-configuration.nix
│
├── flake-modules/
│   ├── features/
│   │   ├── applications/
│   │   ├── audio/
│   │   ├── desktop/
│   │   ├── development/
│   │   ├── overlays/
│   │   └── system/
│   │
│   ├── nixos/
│   ├── overlays/
│   └── users/
│
└── config/
    ├── dms/
    ├── emacs/
    ├── helix/
    ├── kitty/
    ├── matugen/
    ├── niri/
    ├── piri/
    ├── qt5ct/
    ├── qt6ct/
    ├── starship-jj/
    ├── tridactyl/
    ├── yazi/
    └── zellij/
```

### Module organization

| Category       | Responsibility                                                  |
| -------------- | --------------------------------------------------------------- |
| `applications` | Applications, browsers, editors and communication tools         |
| `audio`        | Digital audio workstation configuration                         |
| `desktop`      | Desktop environment, appearance, graphics and gaming            |
| `development`  | Development environment, CLI utilities and terminal tools       |
| `overlays`     | Custom package overlays and package modifications               |
| `system`       | Boot, networking, containers, services and system configuration |

The separation between `features`, `nixos`, `overlays`, and `users` keeps system
composition, reusable functionality, package customization, and user
configuration distinct.

## Stack

| Component           | Technology         |
| ------------------- | ------------------ |
| Operating system    | NixOS              |
| Configuration       | Nix                |
| Flake architecture  | flake-parts        |
| Module discovery    | import-tree        |
| User environment    | Home Manager       |
| Desktop environment | Niri               |
| Desktop shell       | DankMaterialShell  |
| Terminal            | Kitty              |
| Shell               | Fish               |
| Editor              | Helix / Emacs      |
| Browser             | Helium / LibreWolf |
| Styling             | Matugen            |

## Design & workflow

The environment is built around a customized desktop and terminal workflow.

Some of the key components include:

- **Niri** — a scrollable-tiling Wayland compositor.
- **DankMaterialShell** — desktop shell and system interface.
- **Matugen** — dynamic color generation and theming.
- **Fish** — interactive command-line environment.
- **Helix and Emacs** — text editing and development.
- **Kitty and Zellij** — terminal and multiplexer workflow.
- **Yazi** — terminal file manager.
- **Starship** — customizable shell prompt.

Configuration assets are kept separately under `config/`, allowing application
settings and module definitions to remain organized.

## Custom packages

The repository also maintains custom Nix overlays for software that needs
additional packaging or customization.

These include:

- Custom Blender and OBS builds.
- Application wrappers and desktop integrations.
- WiiUDownloader packaging.
- Waydroid-related utilities.
- Audio software and plugins, including REAPER and custom audio plugins.

## Building

Clone the repository:

```bash
git clone <repository-url>
cd framework
```

Build the Home Manager configuration:

```bash
nh home build .
```

Apply the Home Manager configuration:

```bash
nh home switch .
```

Build the NixOS system configuration:

```bash
sudo nixos-rebuild build --flake .#nixos
```

Apply the NixOS configuration:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

**Note:** This configuration is tailored to my hardware and user environment.
Review hardware settings, usernames, paths, and host-specific options before
using it on another machine.

## Repository status

The configuration is actively maintained. Modules, packages, desktop components,
and system settings evolve as the environment changes.

The architecture is designed to make those changes easier to understand and
maintain without turning the configuration into a monolith.

---

<p align="center">
  <sub>Built with Nix. Refined through experimentation. Maintained with intention.</sub>
  <br/>
  <strong>framework</strong>
</p>
