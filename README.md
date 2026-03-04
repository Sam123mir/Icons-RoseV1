<div align="center">
  <img src="https://i.imgur.com/your-image-here.png" alt="RoseUI Icons" height="120" />
  <h1>🌹 RoseUI Icons Library v1</h1>
  <p><strong>La central de recursos de iconos definitiva y de alto rendimiento para proyectos en Roblox.</strong></p>
</div>

---

Esta base de datos universal ha sido diseñada y consolidada para proveer más de **30,000+ Iconos** listos para usar en tus interfaces de usuario (UI) en Roblox. Gracias a su nuevo motor refactorizado, **RoseUI Icons** es ahora más rápido, modular y a prueba de errores.

## ✨ Características Principales

- 🚀 **Lazy Loading (Carga Diferida):** Ya no se cargan megabytes de datos innecesarios. El loader sólo descarga y cachea en memoria la librería específica (ej. *Lucide*, *Solar*) en el instante exacto en que solicitas tu primer icono de esa familia.
- 🔗 **API Universal y Simplificada:** Pide tus iconos usando un formato intuitivo de string `"libreria:icono"` (ej. `"solar:Home"` o `"lucide:user"`). Si omites la librería, usará Lucide por defecto (`"user"`).
- 🛡️ **Prevención de Crasheos (Fallback):** Peticiones protegidas por `pcall`. Si GitHub se cae, el internet falla o solicitas un icono que no existe, el módulo no arrojará errores que destruyan tu UI local, devolverá automáticamente un icono de "Alerta/Precaución" modificable.
- 🧩 **Registro de Librerías Dinámicas:** El código ya no está limitado (hardcoded). Puedes expandir e inyectar tus propios repositorios y librerías de iconos remotamente en tiempo de ejecución.
- 🖼️ **Auto-Detección de Spritesheets:** Compatible nativamente con librerías pesadas particionadas en hojas de sprites (como *Craft* o *Material*). El script detecta por sí mismo el formato y te devuelve los parámetros `ImageRectOffset` y `ImageRectSize`.

## 📦 Librerías Nativas (30,000+ Iconos)

| Librería | Cantidad Aprox. | Fuente Oficial | Estilo Predominante |
| :--- | :--- | :--- | :--- |
| **Lucide** *(Base)* | 1,650+ | [lucide.dev](https://lucide.dev) | Minimalista y Moderno |
| **Solar** | 7,330+ | [solar-icons](https://vovansushkov.github.io/solar-icons/) | Consistente y Diverso |
| **SF Symbols** | 11,000+ | [Apple SF Symbols](https://developer.apple.com/sf-symbols/) | Apple / Premium UI |
| **Geist** | 1,200+ | [Vercel](https://vercel.com/font/icons) | Estricto y Geométrico |
| **Craft** | 5,500+ | [Craft Design](https://craft.design/) | 16px / Pixel-perfect (*Spritesheet*) |

---

## 💻 Documentación y Uso

El archivo `Main.lua` es tu punto de entrada universal. Puedes inicializar la base de datos de forma remota usando `loadstring`:

```lua
local Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sam123mir/Icons-RoseV1/main/Main.lua"))()

-- ==========================================
-- 1. Obtención Básica (Devuelve un string o una tabla)
-- ==========================================

-- Por defecto buscará en la librería Lucide
local userIcon = Icons.GetIcon("user") 

-- Especificando la librería con "libreria:icono"
local homeSolar = Icons.GetIcon("solar:Home")
local sfIcon = Icons.GetIcon("sfsymbols:lock.fill")

-- ==========================================
-- 2. Creación Automática de Interfaz
-- ==========================================

-- Crea una instancia de 'ImageLabel' ya configurada y lista
local myImageLabel = Icons.CreateIcon("craft:2d-axis", {
    Size = UDim2.new(0, 32, 0, 32),
    Color = Color3.fromRGB(255, 255, 255)
})
myImageLabel.Parent = ScreenGui

-- ==========================================
-- 3. Inyectar / Registrar Nuevas Librerías
-- ==========================================

-- Puedes registrar cualquier otra URL o repositorio compatible.
-- El módulo aplicará 'Lazy Loading' y auto-detectará si es Spritesheet o AssetID.
Icons.RegisterLibrary("misIconos", "https://raw.githubusercontent.com/TuUser/Repo/main/mis_iconos.lua")

-- Ahora la nueva librería está disponible globalmente:
local customIcon = Icons.GetIcon("misIconos:Magia")
```

## 📂 Estructura del Repositorio

Para un mantenimiento ordenado, cada familia mantiene su respectivo archivo serializado dentro de la carpeta `dist/`.

- `lucide/dist/Icons.lua`
- `solar/dist/Icons.lua`
- `craft/dist/Icons.lua`
- `geist/dist/Icons.lua`
- `sfsymbols/dist/Icons.lua`

---
<div align="center">
  <p><i>Generado y optimizado para el ecosistema de utilidades de <b>RoseUI</b>.</i></p>
</div>
