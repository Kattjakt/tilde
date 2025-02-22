# ~

An experimental Minecraft shader that adds a funky gradual roll-of to distant terrain, essentially preventing newly loaded chunks from instantly popping into existance and breaking the immersion.

Currently only tested with [Iris](https://modrinth.com/mod/iris) on `1.24.4`, but surely works on other versions as well.

https://github.com/user-attachments/assets/4cbf303c-b6b2-4386-9876-025bb6622edd

[Here's a longer youtube video](https://www.youtube.com/watch?v=4PobR0GUjWA) showcasing the shader. Shot with 30 degrees FOV and a render distance of 16 chunks. The shader currently behaves quite differently based on the render distance and I personally would keep it between 12-16 chunks for the best effect. Will probably get fixed someday - who knows!

### installation

1. Make sure the mods [Sodium](https://modrinth.com/mod/sodium) and [Iris](https://modrinth.com/mod/iris) are installed.
2. Inside the game, navigate to **Options 🡒 Video Settings 🡒 Shader Packs...** (or use the default shortcut `O`) and click the **Open Shader Pack Folder...** button.
3. Download the latest shaderpack [here](https://github.com/Kattjakt/tilde/archive/refs/heads/main.zip) and drag the file to your newly opened shaderpack folder.
4. Now it should appear in your shaderpack-list in-game, so select it and click apply!

### details

The shader is really lightweight and the core idea is _extremely_ simple:

> Basically, every vertex (corner of block) between 90% and 100% of the render distance gets their `y`-position shifted downwards based on its distance to the player. That's it.
>
> If we then add a slight bump right before the downward slope, we also get this nice oscillating jello-effect when the player travels at a constant speed!

### other stuff

The implementation is currently quite naive and hacked together, expect lots of stuff to be broken. Suggestions and PR:s are more than welcome :)

Oh, and if any shader developer out there knows how to, for example,
reuse the standard Minecraft fog functionality instead of having to duplicate some custom implementation into three separate files, please let me know!
