-- [[ 🌹 RoseUI Icons Library v1 - Universal Loader 🌹 ]]
-- Este sistema permite cargar múltiples librerías de iconos de forma modular.
-- Base de Datos compatible con: Lucide, Solar, Craft, Geist, SF Symbols y CustomLibs.

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local HttpService = cloneref(game:GetService("HttpService"))

local Icons = {
    _Version = "1.3.0",
    _Libraries = {
        lucide = "lucide/dist/Icons.lua",
        solar = "solar/dist/Icons.lua",
        craft = "craft/dist/Icons.lua",
        geist = "geist/dist/Icons.lua",
        sfsymbols = "sfsymbols/dist/Icons.lua"
    },
    _Cache = {}
}

-- Configuración del Repositorio Por Defecto
local GITHUB_USER = "Sam123mir"
local GITHUB_REPO = "Icons-RoseV1"
local BASE_URL = string.format("https://raw.githubusercontent.com/%s/%s/main/", GITHUB_USER, GITHUB_REPO)

-- Icono por defecto en caso de fallo u error
local FALLBACK_ICON = "rbxassetid://11400216632"

local FALLBACK_CRAFT = {
    Image = FALLBACK_ICON,
    ImageRectOffset = Vector2.new(0, 0),
    ImageRectSize = Vector2.new(0, 0)
}

-- [[ Función Interna de HTTP ]]
local function Fetch(url)
    local success, result = pcall(function()
        if game and game.HttpGet then
            return game:HttpGet(url)
        else
            return HttpService:GetAsync(url)
        end
    end)
    return success and result or nil
end

-- [[ Registrar o Sobrescribir una Librería Personalizada ]]
function Icons.RegisterLibrary(libName, sourceUrl)
    libName = string.lower(libName)
    Icons._Libraries[libName] = sourceUrl
end

-- [[ Lazy Loading de Librerías ]]
function Icons._GetLibrary(libName)
    libName = string.lower(libName)
    
    if Icons._Cache[libName] then 
        return Icons._Cache[libName] 
    end
    
    local path = Icons._Libraries[libName]
    if not path then
        warn("[RoseUI Icons] Librería no soportada o no registrada: " .. tostring(libName))
        return nil
    end
    
    -- Si la ruta fuente no es un enlace web completo, usamos el repositorio base
    local url = path
    if not string.match(url, "^https?://") then
        url = BASE_URL .. path
    end
    
    local content = Fetch(url)
    if content then
        local success, func = pcall(function()
            local chunk = loadstring(content)
            if chunk then return chunk() end
        end)
        
        if success and type(func) == "table" then
            Icons._Cache[libName] = func
            return func
        end
    else
        warn("[RoseUI Icons] Error de red: No se pudo cargar " .. libName .. " desde " .. url)
    end
    
    return nil
end

-- [[ API Principal: Obtener Icono ]]
function Icons.GetIcon(path)
    if type(path) ~= "string" then return FALLBACK_ICON end

    local libName = "lucide"
    local iconName = path
    
    local splitIndex = string.find(path, ":")
    if splitIndex then
        libName = string.sub(path, 1, splitIndex - 1)
        iconName = string.sub(path, splitIndex + 1)
    end
    
    libName = string.lower(libName)
    local lib = Icons._GetLibrary(libName)
    
    if not lib then
        return FALLBACK_ICON 
    end

    -- Detección Automática Inteligente de Spritesheets (Ej: Craft)
    if lib.Icons and lib.Spritesheets then
        local iconData = lib.Icons[iconName]
        if iconData then
            local spritesheetId = lib.Spritesheets[tostring(iconData.Image)]
            if spritesheetId then
                return {
                    Image = spritesheetId,
                    ImageRectOffset = iconData.ImageRectPosition or iconData.ImageRectOffset,
                    ImageRectSize = iconData.ImageRectSize,
                    IsSpritesheet = true
                }
            end
        end
        return FALLBACK_CRAFT
    else
        -- Formato clásico de diccionarios (AssetID directo)
        local iconId = lib[iconName]
        if iconId then
            return iconId
        end
    end
    
    return FALLBACK_ICON
end

-- [[ Utilidad opcional para crear ImageLabels ]]
function Icons.CreateIcon(path, config)
    local iconData = Icons.GetIcon(path)
    local conf = config or {}
    
    local imageLabel = Instance.new("ImageLabel")
    local _, fName = string.match(path, "(.*):(.*)")
    imageLabel.Name = fName or path
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = conf.Size or UDim2.new(0, 24, 0, 24)
    imageLabel.ImageColor3 = conf.Color or Color3.new(1, 1, 1)

    if type(iconData) == "table" then
        imageLabel.Image = iconData.Image or FALLBACK_ICON
        imageLabel.ImageRectOffset = iconData.ImageRectOffset or Vector2.new(0, 0)
        imageLabel.ImageRectSize = iconData.ImageRectSize or Vector2.new(0, 0)
    else
        imageLabel.Image = iconData or FALLBACK_ICON
        if conf.ImageRectOffset then imageLabel.ImageRectOffset = conf.ImageRectOffset end
        if conf.ImageRectSize then imageLabel.ImageRectSize = conf.ImageRectSize end
    end

    return imageLabel
end

return Icons
