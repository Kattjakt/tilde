# ~

> [!WARNING]
> Still under development. Currently only tested with [Iris](https://modrinth.com/mod/iris) on `1.21.4`

Tilde is a Minecraft shader that makes the world feel _alive_.

https://github.com/user-attachments/assets/4cbf303c-b6b2-4386-9876-025bb6622edd

> [Here's a longer video](https://www.youtube.com/watch?v=4PobR0GUjWA) showcasing the shader.

## About

The shader **only modifies the geometry of distant terrain**<sup>1</sup>, making it extremely lightweight. If you're able to run Minecraft without shaders, you can run Tilde!
Comes with three presets: `Default`, `Increased Motion`, and `Reduced Motion`.

> 1. Small deviations from vanilla may be present as of this time. Modifying the terrain geometry in a shader
>    like this means we have to replicate some aspects of the vanilla style ourself, such as the hand
>    and cloud appearance for example. Feel free to report an issue if you find anything that looks off!

## Installation

1. Make sure the mods [Sodium](https://modrinth.com/mod/sodium) and [Iris](https://modrinth.com/mod/iris) are installed.
2. Inside the game, navigate to **Options 🡒 Video Settings 🡒 Shader Packs...** (or use the default shortcut `O`) and click the **Open Shader Pack Folder...** button.
3. Download the latest shaderpack [here](https://github.com/Kattjakt/tilde/archive/refs/heads/main.zip) and drag the file to your newly opened shaderpack folder.
4. It should now appear in your shaderpack list in-game, so select it and click apply!

## What da shadr doin?

The core idea is _extremely_ simple.
Basically, every vertex (corner of block) between 90% and 100% of the render distance gets their `y`-position shifted up- or downwards in a funky way based on its distance to the player. That's it.

If we then add a slight bump right before the downward slope, we also get this nice oscillating jello-effect when the player travels at a constant speed!

## Credits

- A big thank you to Bestsoft101 for replicating most of the built-in shaders for a proper vanilla look (saved me a lot of time and frustration!): https://github.com/Bestsoft101/Base-Shader
