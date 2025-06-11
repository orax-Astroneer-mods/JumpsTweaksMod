local UEHelpers = require("UEHelpers")

local currentModDirectory = debug.getinfo(1, "S").source:gsub("\\", "/"):match("@?(.+)/[Ss]cripts/")
_G.CurrentModDirectory = currentModDirectory

local format = string.format
local PresetIndex = 1

---@param filename string
---@return boolean
local function isFileExists(filename)
    local file = io.open(filename, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

local function loadDevOptions()
    local file = format([[%s\options.dev.lua]], _G.CurrentModDirectory)

    if isFileExists(file) then
        dofile(file)
    end
end

local function loadOptions()
    local file = format([[%s\options.lua]], _G.CurrentModDirectory)

    if not isFileExists(file) then
        local cmd = format([[copy "%s\options.example.lua" "%s\options.lua"]],
            _G.CurrentModDirectory,
            _G.CurrentModDirectory)

        print("Copy example options to options.lua. Execute command: " .. cmd .. "\n")

        os.execute(cmd)
    end

    return dofile(file)
end

--------------------------------------------------------------------------------

local options = loadOptions() ---@type JumpTweaksMod_Options
loadDevOptions()

--------------------------------------------------------------------------------

---@param moveComp UAstroCharacterMovementComponent
local function setCustomValues(moveComp, preset)
    if moveComp:IsValid() and not moveComp:IsBeingDestroyed() then
        if preset.AirControlDampening ~= nil then
            moveComp.AirControlDampening = preset.AirControlDampening -- 0.3
        end
        if preset.JumpBoostImpulse ~= nil then
            moveComp.JumpBoostImpulse = preset.JumpBoostImpulse -- 0.0
        end
        if preset.JumpVerticalImpulse ~= nil then
            moveComp.JumpVerticalImpulse = preset.JumpVerticalImpulse -- 900.0
        end
        if preset.MinFallingDamageVelocity ~= nil then
            moveComp.MinFallingDamageVelocity = preset.MinFallingDamageVelocity -- 1650.0
        end
        if preset.MaxFallingDamageVelocity ~= nil then
            moveComp.MaxFallingDamageVelocity = preset.MaxFallingDamageVelocity -- 2950.0
        end
    end
end

---@param self UAstroCharacterMovementComponent
---@diagnostic disable-next-line: redundant-parameter
NotifyOnNewObject("/Script/Astro.AstroCharacterMovementComponent", function(self)
    if #options.presets > 0 then
        ExecuteWithDelay(1000, function()
            setCustomValues(self, options.presets[PresetIndex])
        end)
    end
end)

do
    local movementComponents = FindAllOf("AstroCharacterMovementComponent") ---@type UAstroCharacterMovementComponent[]?
    if movementComponents then
        for _, comp in ipairs(movementComponents) do
            setCustomValues(comp, options.presets[PresetIndex])
        end
    end
end

RegisterKeyBind(Key.SPACE, { ModifierKey.CONTROL }, function()
    local AAstroCharacter = UEHelpers.GetPlayer() ---@cast AAstroCharacter ADesignAstro_C
    local index = PresetIndex + 1

    if #options.presets < index then
        PresetIndex = 1
    else
        PresetIndex = index
    end

    print(format("[JumpTweaksMod] Set preset n°%d/%d.", PresetIndex, #options.presets))
    setCustomValues(AAstroCharacter.AstroMovementComponent, options.presets[PresetIndex])
end)
