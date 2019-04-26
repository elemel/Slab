--[[

MIT License

Copyright (c) 2019 Mitchell Davis <coding.jackalope@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]]

local Config = require(SLAB_PATH .. '.Internal.Core.Config')
local Cursor = require(SLAB_PATH .. '.Internal.Core.Cursor')
local FileSystem = require(SLAB_PATH .. '.Internal.Core.FileSystem')
local Utility = require(SLAB_PATH .. '.Internal.Core.Utility')

local API = {}
local Styles = {}

local Style = 
{
	Font = nil,
	FontSize = 14,
	MenuColor = {0.2, 0.2, 0.2, 1.0},
	ScrollBarColor = {0.4, 0.4, 0.4, 1.0},
	ScrollBarHoveredColor = {0.8, 0.8, 0.8, 1.0},
	SeparatorColor = {0.5, 0.5, 0.5, 0.7},
	WindowBackgroundColor = {0.2, 0.2, 0.2, 1.0},
	WindowTitleFocusedColor = {0.26, 0.53, 0.96, 1.0},
	ButtonColor = {0.55, 0.55, 0.55, 1.0},
	RadioButtonSelectedColor = {0.2, 0.2, 0.2, 1.0},
	ButtonHoveredColor = {0.7, 0.7, 0.7, 1.0},
	ButtonPressedColor = {0.8, 0.8, 0.8, 1.0},
	CheckBoxSelectedColor = {0.0, 0.0, 0.0, 1.0},
	TextColor = {0.875, 0.875, 0.875, 1.0},
	TextHoverBgColor = {0.5, 0.5, 0.5, 1.0},
	ComboBoxColor = {0.4, 0.4, 0.4, 1.0},
	ComboBoxHoveredColor = {0.55, 0.55, 0.55, 1.0},
	ComboBoxDropDownColor = {0.4, 0.4, 0.4, 1.0},
	ComboBoxDropDownHoveredColor = {0.55, 0.55, 0.55, 1.0},
	ComboBoxArrowColor = {1.0, 1.0, 1.0, 1.0},
	InputBgColor = {0.4, 0.4, 0.4, 1.0},
	InputEditBgColor = {0.5, 0.5, 0.5, 1.0},
	InputSelectColor = {0.14, 0.29, 0.53, 0.4},

	WindowRounding = 2.0,
	ButtonRounding = 2.0,
	CheckBoxRounding = 2.0,
	ComboBoxRounding = 2.0,
	InputBgRounding = 2.0,
	ScrollBarRounding = 2.0,

	API = API
}

function API.Initialize()
	Style.Font = love.graphics.newFont(Style.FontSize)
	Cursor.SetNewLineSize(Style.Font:getHeight())

	local StylePath = "/Internal/Resources/Styles/"
	local Path = FileSystem.GetSlabPath() .. StylePath
	local Items = FileSystem.GetDirectoryItems(Path, {Files = true, Directories = false, Filter = "*.style"})

	for I, V in ipairs(Items) do
		local LoadedStyle = API.LoadStyle(StylePath .. V)

		if LoadedStyle ~= nil then
			local Name = FileSystem.RemoveExtension(V)
			Styles[Name] = LoadedStyle
		end
	end
end

function API.LoadStyle(Path)
	local FullPath = FileSystem.GetSlabPath() .. Path
	local Contents, Error = Config.LoadFile(FullPath)
	if Contents == nil then
		print("Failed to load style '" .. FileSystem.GetBaseName(Path) .. "'.\n" .. Error)
	end
	return Contents
end

function API.SetStyle(Name)
	local Other = Styles[Name]
	if Other ~= nil then
		for K, V in pairs(Style) do
			local New = Other[K]
			if New ~= nil then
				if type(V) == "table" then
					Utility.Copy(Style[K], New)
				else
					Style[K] = New
				end
			end
		end
	else
		print("Style '" .. Name .. "' is not loaded.")
	end
end

return Style
