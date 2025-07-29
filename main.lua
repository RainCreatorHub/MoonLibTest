local urls = {}
urls.Owner = "https://raw.githubusercontent.com/RainCreatorHub/"
urls.Repository = urls.Owner .. "MoonLibTest/refs/heads/main/"
urls.Elements = urls.Repository .. "Elementos/"
urls.Window = urls.Repository .. "Window/"

-- Carregar módulos
local OrionLibV2 = require(urls.Window .. "MakeWindow.lua")
local Tabs = require(urls.Window .. "MakeTab.lua")

-- Carregar elementos
local AddSection = require(urls.Elements .. "AddSection.lua")
local AddLabel = require(urls.Elements .. "AddLabel.lua")
local AddButton = require(urls.Elements .. "AddButton.lua")
local AddToggle = require(urls.Elements .. "AddToggle.lua")
local AddDropdown = require(urls.Elements .. "AddDropdown.lua")
