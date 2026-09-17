# Pong Clone

A small single-player Pong clone built with Godot.

This project was created primarily as a beginner game-development exercise, so the focus is on implementing the core gameplay loop rather than polish, production-ready architecture, or a large feature set.

## Features

- Player-controlled paddle
- AI-controlled opponent
- Ball collision and bouncing
- Score tracking
- Win condition
- Increasing ball speed after paddle hits

## Controls

Move the mouse vertically to control the player paddle.

## Play

Windows builds are available from the repository's **Releases** page.

Download the latest release, extract it, and run:

```text
PongClone.exe
```

## Run From Source

This project was originally created with Godot 4.2.2 and has since been updated to work with a newer Godot 4.x version.

To run it from source:

1. Clone the repository.
2. Open the project in Godot 4.x.
3. Run the main scene with `F6` or the full project with `F5`.

## Project Structure

```text
assets/     Game textures and other assets
scenes/     Godot scenes
scripts/    GDScript gameplay logic
```

## About This Project

`pong-clone` is intentionally small.

It was built as a hands-on exercise for learning foundational Godot concepts such as:

- 2D scenes and nodes
- CharacterBody2D movement
- collision detection
- basic AI behavior
- game state and scoring
- exporting a playable build

The goal was to make a complete, playable version of Pong rather than turn it into a larger or highly polished game.

## Known Scope

This is a simple practice project and does not currently include features such as:

- menus or settings
- difficulty selection
- sound or music
- multiplayer
- extensive visual polish

## Development

The game can be exported using Godot's Windows export preset.

Before publishing a release, the exported build should be tested independently of the Godot editor to confirm that gameplay and assets behave correctly in the packaged version.

## License

Licensed under the MIT License. See [`LICENSE`](LICENSE).
