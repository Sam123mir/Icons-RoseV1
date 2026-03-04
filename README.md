# 🌹 RoseUI Icons Library v1 - 30k+ Professional Icons

La central de recursos de iconos definitiva para RoseUI y cualquier proyecto de Roblox. Esta base de datos ha sido dumpeada de fuentes oficiales y consolidada para un rendimiento óptimo.

## 📦 Librerías Incluidas (30,000+ Iconos)

| Librería | Cantidad Aprox. | Fuente Oficial | Formato |
| :--- | :--- | :--- | :--- |
| **Lucide** | 1,650+ | [lucide.dev](https://lucide.dev) | AssetID |
| **Solar** | 7,330+ | [solar-icons](https://vovansushkov.github.io/solar-icons/) | AssetID |
| **SF Symbols** | 11,000+ | [Apple SF Symbols](https://developer.apple.com/sf-symbols/) | AssetID |
| **Geist** | 1,200+ | [Vercel Geist](https://vercel.com/font/icons) | AssetID |
| **Craft** | 5,500+ | [Craft Design](https://craft.design/) | Spritesheets |

## 🚀 Cómo usar el Cargador Universal

El archivo `Main.lua` es el punto de entrada. Puedes cargarlo mediante `loadstring` desde tu repositorio de GitHub.

```lua
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sam123mir/Icons-RoseV1/main/Main.lua"))()

-- 1. Obtener un AssetID simple (Lucide, Solar, SFSymbols)
local homeIcon = Icons:Get("Lucide", "home") -- rbxassetid://...

-- 2. Obtener datos de Spritesheet (Craft)
local craftIcon = Icons:Get("Craft", "2d-axis-stroke") 
-- Retorna {Image = "...", ImageRectPosition = ..., ImageRectSize = ...}

-- 3. Crear una ImageLabel automáticamente
local myLabel = Icons:Create("Solar", "heart-bold", {
    Size = UDim2.new(0, 32, 0, 32),
    Color = Color3.fromRGB(255, 100, 100)
})
myLabel.Parent = ScreenGui
```

## 📂 Estructura del Dump

Cada carpeta contiene un archivo `dist/Icons.lua` con la base de datos completa serializada para Roblox.

- `lucide/dist/Icons.lua`
- `solar/dist/Icons.lua`
- `craft/dist/Icons.lua` (Soporte nativo para Spritesheets)
- `geist/dist/Icons.lua`
- `sfsymbols/dist/Icons.lua`

---
*Dump generado para RoseUI v3.0 Premium.*
