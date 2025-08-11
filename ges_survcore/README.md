# GES Survival Core

Blizzard Survival Core providing temperature, wetness, heat sources and blizzard control.

## Install

1. Copy resource folder `ges_survcore` into your `resources` directory.
2. Copy `config.example.lua` to `config.lua` and adjust values.
3. Add `ensure ges_survcore` to your `server.cfg`.

## Strict / Fallback

`Config.Core.Strict` stops the resource if config or dependencies are missing.
Set `AllowFallback` to true for development to use internal fallbacks.

## Exports

```lua
local temp = exports.ges_survcore:Temp_Get()
local wet = exports.ges_survcore:Wetness_Get()
exports.ges_survcore:Heat_RegisterSource('campfire', vec3(0,0,0), 5.0, 2.0)
exports.ges_survcore:Blizzard_Start(0.5, 60)
```

## Admin ACE

```
add_ace group.admin ges.blizzard allow
```

## External Resources

Automatically detects `GES-Temperature` or `ges_temperature` and `renewed-weathersync` if present.
