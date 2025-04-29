--[[
Commented lines are ignored. If you don't want to change a value, comment out the line.
"A comment starts anywhere with a double hyphen (--) and runs until the end of the line." https://www.lua.org/pil/1.3.html

]]

---@type JumpTweaksMod_Options
return {
    AirControlDampening = 0.6,       -- 0.3
    JumpBoostImpulse = 0,            -- 0.0
    JumpVerticalImpulse = 1800,      -- 900.0
    -- MinFallingDamageVelocity = 1650, -- 1650.0
    MaxFallingDamageVelocity = 5900, -- 2950.0
}
