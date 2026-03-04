-- [[ 🌹 RoseUI Icons Library v1 - Universal Loader 🌹 ]]
-- Este sistema permite cargar múltiples librerías de iconos de forma modular.
-- Base de Datos compatible con: Lucide, Solar, Craft, Geist, SF Symbols.
-- Inspirado en Footagesus/Icons.

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local HttpService = cloneref(game:GetService("HttpService"))

local Icons = {
    _Version = "1.1.0",
    _Libraries = {
        Lucide = "lucide/dist/Icons.lua",
        Solar = "solar/dist/Icons.lua",
        Craft = "craft/dist/Icons.lua",
        Geist = "geist/dist/Icons.lua",
        SFSymbols = "sfsymbols/dist/Icons.lua"
    },
    _Cache = {}
}

-- Configuración del Repositorio (Cambiar esto al repositorio final del usuario)
local GITHUB_USER = "Sam123mir"
local GITHUB_REPO = "Icons-RoseV1"
local BASE_URL = string.format("https://raw.githubusercontent.com/%s/%s/main/", GITHUB_USER, GITHUB_REPO)

-- [[ Función Interna de HTTP ]]
local function Get(url)
    local success, result = pcall(function()
        if game.HttpGet then
            return game:HttpGet(url)
        else
            return HttpService:GetAsync(url)
        end
    end)
    return success and result or nil
end

-- [[ Cargar una Librería Específica ]]
function Icons:GetLibrary(libName)
    if self._Cache[libName] then return self._Cache[libName] end
    
    local path = self._Libraries[libName]
    if not path then
        warn("[RoseUI Icons] Librería no encontrada: " .. tostring(libName))
        return nil
    end
    
    local content = Get(BASE_URL .. path)
    if content then
        local success, func = pcall(function()
            local chunk = loadstring(content)
            if chunk then return chunk() end
        end)
        
        if success and type(func) == "table" then
            self._Cache[libName] = func
            return func
        end
    end
    
    warn("[RoseUI Icons] Error al cargar " .. libName .. " desde el repositorio.")
    return nil
end

-- [[ Obtener un Icono Específico (Sintaxis simplificada) ]]
function Icons:Get(libName, iconName)
    local lib = self:GetLibrary(libName)
    if not lib then return nil end

    if libName == "Craft" then
        -- Craft usa spritesheets (Icons[name] = {ImageRectPosition, ImageRectSize, Image})
        local iconData = lib.Icons and lib.Icons[iconName]
        if iconData then
            -- Resolver ID de imagen desde la tabla de Spritesheets
            local spritesheetId = lib.Spritesheets[tostring(iconData.Image)]
            return {
                Image = spritesheetId,
                ImageRectPosition = iconData.ImageRectPosition,
                ImageRectSize = iconData.ImageRectSize
            }
        end
    else
        -- Otras librerías suelen ser tablas directas [name] = "rbxassetid://..."
        return lib[iconName]
    end
    
    return nil
end

-- [[ Utilidad para crear ImageLabels rápidamente ]]
function Icons:Create(libName, iconName, config)
    local iconData = self:Get(libName, iconName)
    if not iconData then return nil end

    local conf = config or {}
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = iconName
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = conf.Size or UDim2.new(0, 24, 0, 24)
    imageLabel.ImageColor3 = conf.Color or Color3.new(1, 1, 1)

    if type(iconData) == "table" then
        -- Formato Spritesheet
        imageLabel.Image = iconData.Image
        imageLabel.ImageRectPosition = iconData.ImageRectPosition
        imageLabel.ImageRectSize = iconData.ImageRectSize
    else
        -- Formato AssetID simple
        imageLabel.Image = iconData
    end

    return imageLabel
end

return Icons
