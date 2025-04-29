--[[
Commented lines are ignored. If you don't want to change a value, comment out the line.
"A comment starts anywhere with a double hyphen (--) and runs until the end of the line." https://www.lua.org/pil/1.3.html
]]

--[[
Game defaults:
    AirControlDampening = 0.3
    JumpBoostImpulse = 0.0
    JumpVerticalImpulse = 900.0
    MinFallingDamageVelocity = 1650.0
    MaxFallingDamageVelocity = 2950.0
]]

---@type JumpTweaksMod_Options
return {
    -- The first preset is the one that is loaded when you start the game.
    -- You can add more presets.
    presets = {
        {
            AirControlDampening = 0.6,
            -- JumpBoostImpulse = 0,
            JumpVerticalImpulse = 1800,
            -- MinFallingDamageVelocity = 1650,
            MaxFallingDamageVelocity = 5900,
        },
        {
            AirControlDampening = 0.3,
            -- JumpBoostImpulse = 0,
            JumpVerticalImpulse = 900,
            -- MinFallingDamageVelocity = 1650,
            -- MaxFallingDamageVelocity = 2950,
        },
    },
    -- Press CTRL+SPACE to switch between presets.
    -- To disable this keybind, comment out the lines below.
    -- Key-code strings: https://docs.ue4ss.com/dev/lua-api/table-definitions/key.html
    -- Modifier key-code strings: https://docs.ue4ss.com/dev/lua-api/table-definitions/modifierkey.html
    keybinds = {
        key = Key.SPACE,
        modifierKeys = { ModifierKey.CONTROL }
    }
}
