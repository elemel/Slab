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

local Slab = require('Slab')
local SlabDebug = require(SLAB_PATH .. '.SlabDebug')

local SlabTest = {}

local function DrawOverview()
	Slab.Textf(
		"Slab is an immediate mode GUI toolkit for the LÖVE 2D framework. This library " ..
		"is designed to allow users to easily add this library to their existing LÖVE 2D projects and " ..
		"quickly create tools to enable them to iterate on their ideas quickly. The user should be able " ..
		"to utilize this library with minimal integration steps and is completely written in Lua and utilizes " ..
		"the LÖVE 2D API. No compiled binaries are required and the user will have access to the source so " ..
		"that they may make adjustments that meet the needs of their own projects and tools. Refer to main.lua " ..
		"and SlabTest.lua for example usage of this library.\n\n" ..
		"This window will demonstrate the usage of the Slab library and give an overview of all the supported controls " ..
		"and features.")

	Slab.NewLine()

	Slab.Text("The current version of Slab is: ")
	Slab.SameLine()
	Slab.Text(Slab.GetVersion(), {Color = {0, 1, 0, 1}})

	Slab.Text("The current version of LÖVE is: ")
	Slab.SameLine()
	Slab.Text(Slab.GetLoveVersion(), {Color = {0, 1, 0, 1}})
end

local DrawButtons_NumClicked = 0
local DrawButtons_NumClicked_Invisible = 0
local DrawButtons_Enabled = false
local DrawButtons_Hovered = false

local function DrawButtons()
	Slab.Textf("Buttons are simple controls which respond to a user's left mouse click. Buttons will simply return true when they are clicked.")

	Slab.NewLine()

	if Slab.Button("Button") then
		DrawButtons_NumClicked = DrawButtons_NumClicked + 1
	end

	Slab.SameLine()
	Slab.Text("You have clicked this button " .. DrawButtons_NumClicked .. " time(s).")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can be tested for mouse hover with the call to Slab.IsControlHovered right after declaring the button.")
	Slab.Button(DrawButtons_Hovered and "Hovered" or "Not Hovered", {W = 100})
	DrawButtons_Hovered = Slab.IsControlHovered()

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Buttons can be aligned to fit on the right side of the of window. When multiple buttons are declared with this " ..
		"option set along with Slab.SameLine call, each button will be moved over to make room for the new aligned button.")

	Slab.Button("Cancel", {AlignRight = true})
	Slab.SameLine()
	Slab.Button("OK", {AlignRight = true})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can be set to expand to the size of the window.")
	Slab.Button("Expanded Button", {ExpandW = true})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can have a custom width and height.")
	Slab.Button("Square", {W = 75, H = 75})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Buttons can also be invisible. Below is a rectangle with an invisible button so that the designer can " ..
		"implement a custom button but still rely on the button behavior. Below is a custom rectangle drawn with an " ..
		"invisible button drawn at the same location.")
	local X, Y = Slab.GetCursorPos()
	Slab.Rectangle({Mode = 'line', W = 50.0, H = 50.0, Color = {1, 1, 1, 1}})
	Slab.SetCursorPos(X, Y)

	if Slab.Button("", {Invisible = true, W = 50.0, H = 50.0}) then
		DrawButtons_NumClicked_Invisible = DrawButtons_NumClicked_Invisible + 1
	end

	Slab.SameLine({CenterY = true})
	Slab.Text("Invisible button has been clicked " .. DrawButtons_NumClicked_Invisible .. " time(s).")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can also be disabled. Click the button below to toggle the status of the neighboring button.")

	if Slab.Button("Toggle") then
		DrawButtons_Enabled = not DrawButtons_Enabled
	end

	Slab.SameLine()
	Slab.Button(DrawButtons_Enabled and "Enabled" or "Disabled", {Disabled = not DrawButtons_Enabled})
end

local DrawText_Width = 450.0
local DrawText_Alignment = {'left', 'center', 'right', 'justify'}
local DrawText_Alignment_Selected = 'left'
local DrawText_NumClicked = 0
local DrawText_NumClicked_TextOnly = 0

local function DrawText()
	Slab.Textf("Text controls displays text on the current window. Slab currently offers three ways to control the text.")

	Slab.NewLine()
	Slab.Separator()

	Slab.Text("The most basic text control is Slab.Text.")
	Slab.Text("The color of the text can be controlled with the 'Color' option.", {Color = {0, 1, 0, 1}})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Text can be formatted using the Slab.Textf API. Formatted text will wrap the text based on the 'W' option. " ..
		"If the 'W' option is not specified, the window's width will be used as the width. Formatted text also has an " ..
		"alignment option.")

	Slab.NewLine()
	Slab.Text("Width")
	Slab.SameLine()
	if Slab.Input('DrawText_Width', {Text = tostring(DrawText_Width), NumbersOnly = true, ReturnOnText = false}) then
		DrawText_Width = Slab.GetInputNumber()
	end

	Slab.SameLine()
	Slab.Text("Alignment")
	Slab.SameLine()
	if Slab.BeginComboBox('DrawText_Alignment', {Selected = DrawText_Alignment_Selected}) then
		for I, V in ipairs(DrawText_Alignment) do
			if Slab.TextSelectable(V) then
				DrawText_Alignment_Selected = V
			end
		end

		Slab.EndComboBox()
	end

	Slab.Textf(
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore " ..
		"et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut " ..
		"aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum " ..
		"dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui " ..
		"officia deserunt mollit anim id est laborum.", {W = DrawText_Width, Align = DrawText_Alignment_Selected})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Text can also be interacted with using the Slab.TextSelectable function. A background will be " ..
		"rendered when the mouse is hovered over the text and the function will return true when clicked on. " ..
		"The selectable area expands to the width of the window by default. This can be changed to just the text " ..
		"with the 'IsSelectableTextOnly' option.")

	Slab.NewLine()
	if Slab.TextSelectable("This text has been clicked " .. DrawText_NumClicked .. " time(s).") then
		DrawText_NumClicked = DrawText_NumClicked + 1
	end

	Slab.NewLine()
	if Slab.TextSelectable("This text has been clicked " .. DrawText_NumClicked_TextOnly .. " time(s).", {IsSelectableTextOnly = true}) then
		DrawText_NumClicked_TextOnly = DrawText_NumClicked_TextOnly + 1
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Text can also be centered horizontally within the bounds of the window.")

	Slab.NewLine()
	Slab.Text("Centered Text", {CenterX = true})
end

local DrawCheckBox_Checked = false
local DrawCheckBox_Checked_NoLabel = false

local function DrawCheckBox()
	Slab.Textf(
		"Check boxes are controls that will display an empty box with an optional label. The function will " ..
		"return true if the user has clicked on the box. The code is then responsible for updating the checked " ..
		"flag to be passed back into the function.")

	Slab.NewLine()
	if Slab.CheckBox(DrawCheckBox_Checked, "Check Box") then
		DrawCheckBox_Checked = not DrawCheckBox_Checked
	end

	Slab.NewLine()
	Slab.Text("A check box with no label.")
	if Slab.CheckBox(DrawCheckBox_Checked_NoLabel) then
		DrawCheckBox_Checked_NoLabel = not DrawCheckBox_Checked_NoLabel
	end
end

local DrawRadioButton_Selected = 1

local function DrawRadioButton()
	Slab.Textf("Radio buttons offer the user to select one option from a list of options.")

	Slab.NewLine()
	for I = 1, 5, 1 do
		if Slab.RadioButton("Option " .. I, {Index = I, SelectedIndex = DrawRadioButton_Selected}) then
			DrawRadioButton_Selected = I
		end
	end
end

local DrawMenus_Window_Selected = "Right click and select an option."
local DrawMenus_Control_Selected = "Right click and select an option from a control."
local DrawMenus_CheckBox = false
local DrawMenus_ComboBox = {"Apple", "Banana", "Pear", "Orange", "Lemon"}
local DrawMenus_ComboBox_Selected = "Apple"

local function DrawContextMenuItem(Label)
	if Slab.BeginContextMenuItem() then
		for I = 1, 5, 1 do
			local MenuLabel = Label .. " Option " .. I
			if Slab.MenuItem(MenuLabel) then
				DrawMenus_Control_Selected = MenuLabel
			end
		end

		Slab.EndContextMenu()
	end
end

local function DrawMenus()
	Slab.Textf(
		"Menus are windows that allow users to make a selection from a list of items. " ..
		"Below are descriptions of the various menus and how they can be utilized.")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"The main menu bar is rendered at the top of the window with menu items being added " ..
		"from left to right. When a menu item is clicked, a context menu is opened below the " ..
		"selected item. Creating the main menu bar can open anywhere in the code after the " ..
		"Slab.Update call. These functions should not be called within a BeginWindow/EndWindow " ..
		"call.")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Context menus are menus which are rendered above all other controls to allow the user to make a selection " ..
		"out of a list of items. These can be opened up through the menu bar, or through a right-click " ..
		"action from the user on a given window or control. Menus and menu items make up the context menu " ..
		"and menus can be nested to allow a tree options to be displayed.")

	Slab.NewLine()

	Slab.Textf(
		"Controls can have their own context menus. Right-click on each control to open up the menu " ..
		"and select an option.")

	Slab.NewLine()
	Slab.Text(DrawMenus_Control_Selected)
	Slab.NewLine()

	Slab.Button("Button")
	DrawContextMenuItem("Button")

	Slab.Text("Text")
	DrawContextMenuItem("Text")

	if Slab.CheckBox(DrawMenus_CheckBox, "Check Box") then
		DrawMenus_CheckBox = not DrawMenus_CheckBox
	end
	DrawContextMenuItem("Check Box")

	Slab.Input('DrawMenus_Input')
	DrawContextMenuItem("Input")

	if Slab.BeginComboBox('DrawMenus_ComboBox', {Selected = DrawMenus_ComboBox_Selected}) then
		for I, V in ipairs(DrawMenus_ComboBox) do
			if Slab.TextSelectable(V) then
				DrawMenus_Window_Selected = V
			end
		end

		Slab.EndComboBox()
	end
	DrawContextMenuItem("Combo Box")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Right-clicking anywhere within this window will open up a context menu. Note that BeginContextMenuWindow " ..
		"must come after all BeginContextMenuItem calls.")

	Slab.NewLine()

	Slab.Textf(DrawMenus_Window_Selected)

	if Slab.BeginContextMenuWindow() then
		if Slab.BeginMenu("Window Menu 1") then
			for I = 1, 5, 1 do
				if Slab.MenuItem("Sub Window Option " .. I) then
					DrawMenus_Window_Selected = "Sub Window Option " .. I .. " selected."
				end
			end

			Slab.EndMenu()
		end

		for I = 1, 5, 1 do
			if Slab.MenuItem("Window Option " .. I) then
				DrawMenus_Window_Selected = "Window Option " .. I .. " selected."
			end
		end

		Slab.EndContextMenu()
	end
end

local DrawComboBox_Options = {"England", "France", "Germany", "USA", "Canada", "Mexico", "Japan", "South Korea", "China", "Russia", "India"}
local DrawComboBox_Selected = "USA"
local DrawComboBox_Selected_Width = "USA"

local function DrawComboBox()
	Slab.Textf(
		"A combo box allows the user to select a single item from a list and display the selected item " ..
		"in the combo box. The list is only visible when the user is interacting with the control.")

	Slab.NewLine()

	if Slab.BeginComboBox('DrawComboBox_One', {Selected = DrawComboBox_Selected}) then
		for I, V in ipairs(DrawComboBox_Options) do
			if Slab.TextSelectable(V) then
				DrawComboBox_Selected = V
			end
		end

		Slab.EndComboBox()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("A combo box's width can be modified with the 'W' option.")

	Slab.NewLine()

	local W, H = Slab.GetWindowActiveSize()
	if Slab.BeginComboBox('DrawComboBox_Two', {Selected = DrawComboBox_Selected_Width, W = W}) then
		for I, V in ipairs(DrawComboBox_Options) do
			if Slab.TextSelectable(V) then
				DrawComboBox_Selected_Width = V
			end
		end

		Slab.EndComboBox()
	end
end

local DrawInput_Basic = "Hello World"
local DrawInput_Basic_Return = "Hello World"
local DrawInput_Basic_Numbers = 0
local DrawInput_Basic_Numbers_Clamped = 0.5
local DrawInput_MultiLine = 
[[
function Foo()
	print("Bar")
end

The quick brown fox jumped over the lazy dog.]]
local DrawInput_MultiLine_Width = math.huge

local function DrawInput()
	Slab.Textf(
		"The input control allows the user to enter in text into an input box. This control is similar " ..
		"to input boxes found in other applications.")

	Slab.NewLine()

	Slab.Textf(
		"The first example is very simple. An Input control is declared and the resulting text is captured if " ..
		"the function returns true. By default, the function will return true on any text that is entered.")

	if Slab.Input('DrawInput_Basic', {Text = DrawInput_Basic}) then
		DrawInput_Basic = Slab.GetInputText()
	end

	Slab.NewLine()

	Slab.Textf(
		"The return behavior can be modified so that the function will only return true if the Enter/Return " ..
		"key is pressed. If the control loses focus without the Enter/Return key pressed, then the text will " ..
		"revert back to what it was before.")

	if Slab.Input('DrawInput_Basic_Return', {Text = DrawInput_Basic_Return, ReturnOnText = false}) then
		DrawInput_Basic_Return = Slab.GetInputText()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Input controls can be configured to only take numeric values.")

	if Slab.Input('DrawInput_Basic_Numbers', {Text = tostring(DrawInput_Basic_Numbers), NumbersOnly = true}) then
		DrawInput_Basic_Numbers = Slab.GetInputNumber()
	end

	Slab.NewLine()

	Slab.Textf(
		"These numeric controls can also have min and/or max values set. Below is an example where the " ..
		"numeric input control is clamped from 0.0 to 1.0.")

	if Slab.Input('DrawInput_Basic_Numbers_Clamped', {Text = tostring(DrawInput_Basic_Numbers_Clamped), NumbersOnly = true, MinNumber = 0.0, MaxNumber = 1.0}) then
		DrawInput_Basic_Numbers_Clamped = Slab.GetInputNumber()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Input controls also allow for multi-line editing using the MultiLine option. The default text wrapping " ..
		"option is set to math.huge, but this can be modified with the MultiLineW option. The example below demonstrates " ..
		"how to set up a multi-line input control and shows how the size of the control can be modified.")

	Slab.NewLine()
	Slab.Text("MultiLineW")
	Slab.SameLine()
	if Slab.Input('DrawInput_MultiLine_Width', {Text = tostring(DrawInput_MultiLine_Width), NumbersOnly = true, ReturnOnText = false}) then
		DrawInput_MultiLine_Width = Slab.GetInputNumber()
	end

	local W, H = Slab.GetWindowActiveSize()

	if Slab.Input('DrawInput_MultiLine', {Text = DrawInput_MultiLine, MultiLine = true, MultiLineW = DrawInput_MultiLine_Width, W = W, H = 150.0}) then
		DrawInput_MultiLine = Slab.GetInputText()
	end
end

local DrawImage_Path = SLAB_PATH .. "/Internal/Resources/Textures/power.png"
local DrawImage_Path_Icons = SLAB_PATH .. "/Internal/Resources/Textures/gameicons.png"
local DrawImage_Color = {1, 0, 0, 1}
local DrawImage_Color_Edit = false
local DrawImage_Scale = 1.0
local DrawImage_Scale_X = 1.0
local DrawImage_Scale_Y = 1.0
local DrawImage_Power = false
local DrawImage_Power_Hovered = false
local DrawImage_Power_On = {0, 1, 0, 1}
local DrawImage_Power_Off = {1, 0, 0, 1}
local DrawImage_Icon_X = 0
local DrawImage_Icon_Y = 0
local DrawImage_Icon_Move = false

local function DrawImage()
	Slab.Textf(
		"Images can be drawn within windows and react to user interaction. A path to an image can be specified through the options of " ..
		"the Image function. If this is done, Slab will manage the image resource and will use the path as a key to the resource.")

	Slab.Image('DrawImage_Basic', {Path = DrawImage_Path})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"An image's color can be modified with the 'Color' option.")

	if Slab.Button("Change Color") then
		DrawImage_Color_Edit = true
	end

	if DrawImage_Color_Edit then
		local Result = Slab.ColorPicker({Color = DrawImage_Color})

		if Result.Button ~= "" then
			DrawImage_Color_Edit = false

			if Result.Button == "OK" then
				DrawImage_Color = Result.Color
			end
		end
	end

	Slab.Image('DrawImage_Color', {Path = DrawImage_Path, Color = DrawImage_Color})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"There is an option to modify the scale of an image. The scale can both be affected " ..
		"on the X or Y axis.")

	Slab.Text("Scale")
	Slab.SameLine()
	if Slab.Input('DrawImage_Scale', {Text = tostring(DrawImage_Scale), NumbersOnly = true, ReturnOnText = false, W = 75}) then
		DrawImage_Scale = Slab.GetInputNumber()
		DrawImage_Scale_X = DrawImage_Scale
		DrawImage_Scale_Y = DrawImage_Scale
	end

	Slab.SameLine({Pad = 6.0})
	Slab.Text("Scale X")
	Slab.SameLine()
	if Slab.Input('DrawImage_Scale_X', {Text = tostring(DrawImage_Scale_X), NumbersOnly = true, ReturnOnText = false, W = 75}) then
		DrawImage_Scale_X = Slab.GetInputNumber()
	end

	Slab.SameLine({Pad = 6.0})
	Slab.Text("Scale Y")
	Slab.SameLine()
	if Slab.Input('DrawImage_Scale_Y', {Text = tostring(DrawImage_Scale_Y), NumbersOnly = true, ReturnOnText = false, W = 75}) then
		DrawImage_Scale_Y = Slab.GetInputNumber()
	end

	Slab.Image('DrawImage_Scale', {Path = DrawImage_Path, ScaleX = DrawImage_Scale_X, ScaleY = DrawImage_Scale_Y})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Images can also have interactions through the control API. The left image will change when the mouse is hovered " ..
		"while the right image will change on click.")

	Slab.Image('DrawImage_Hover', {Path = DrawImage_Path, Color = DrawImage_Power_Hovered and DrawImage_Power_On or DrawImage_Power_Off})
	DrawImage_Power_Hovered = Slab.IsControlHovered()

	Slab.SameLine({Pad = 12.0})
	Slab.Image('DrawImage_Click', {Path = DrawImage_Path, Color = DrawImage_Power and DrawImage_Power_On or DrawImage_Power_Off})
	if Slab.IsControlClicked() then
		DrawImage_Power = not DrawImage_Power
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"A sub region can be defined to draw a section of an image. Move the rectangle around and observe the image on the right.")

	local X, Y = Slab.GetCursorPos()
	local AbsX, AbsY = Slab.GetCursorPos({Absolute = true})
	Slab.Image('DrawImage_Icons', {Path = DrawImage_Path_Icons})
	if Slab.IsControlClicked() then
		local MouseX, MouseY = Slab.GetMousePositionWindow()
		local Left = AbsX + DrawImage_Icon_X
		local Right = Left + 50.0
		local Top = AbsY + DrawImage_Icon_Y
		local Bottom = Top + 50.0
		if Left <= MouseX and MouseX <= Right and
			Top <= MouseY and MouseY <= Bottom then
			DrawImage_Icon_Move = true
		end
	end

	if Slab.IsMouseReleased() then
		DrawImage_Icon_Move = false
	end

	local W, H = Slab.GetControlSize()

	if DrawImage_Icon_Move then
		local DeltaX, DeltaY = Slab.GetMouseDelta()
		DrawImage_Icon_X = math.max(DrawImage_Icon_X + DeltaX, 0.0)
		DrawImage_Icon_X = math.min(DrawImage_Icon_X, W - 50.0)

		DrawImage_Icon_Y = math.max(DrawImage_Icon_Y + DeltaY, 0.0)
		DrawImage_Icon_Y = math.min(DrawImage_Icon_Y, H - 50.0)
	end

	Slab.SetCursorPos(X + DrawImage_Icon_X, Y + DrawImage_Icon_Y)
	Slab.Rectangle({Mode = 'line', Color = {0, 0, 0, 1}, W = 50.0, H = 50.0})

	Slab.SetCursorPos(X + W + 12.0, Y)
	Slab.Image('DrawImage_Icons_Region', {
		Path = DrawImage_Path_Icons,
		SubX = DrawImage_Icon_X,
		SubY = DrawImage_Icon_Y,
		SubW = 50.0,
		SubH = 50.0
	})
end

local DrawCursor_NewLines = 1
local DrawCursor_SameLinePad = 4.0
local DrawCursor_X = nil
local DrawCursor_Y = nil

local function DrawCursor()
	Slab.Textf(
		"Slab offers a way to manage the drawing of controls through the cursor. Whenever a control is used, the cursor is "..
		"automatically advanced based on the size of the control. By default, cursors are advanced vertically downward based " ..
		"on the control's height. However, functions are provided to move the cursor back up to the previous line or create " ..
		"an empty line to advance the cursor downward.")

	for I = 1, DrawCursor_NewLines, 1 do
		Slab.NewLine()
	end

	Slab.Textf(
		"There is a new line between this text and the above description. Modify the number of new lines using the " ..
		"input box below.")
	if Slab.Input('DrawCursor_NewLines', {Text = tostring(DrawCursor_NewLines), NumbersOnly = true, ReturnOnText = false, MinNumber = 0}) then
		DrawCursor_NewLines = Slab.GetInputNumber()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Using the SameLine function, controls can be layed out on a single line with additional padding. Below are two buttons on " ..
		"the same line with some padding. Use the input field below to modify the padding.")
	Slab.Button("One")
	Slab.SameLine({Pad = DrawCursor_SameLinePad})
	Slab.Button("Two")
	if Slab.Input('DrawCursor_SameLinePad', {Text = tostring(DrawCursor_SameLinePad), NumbersOnly = true, ReturnOnText = false}) then
		DrawCursor_SameLinePad = Slab.GetInputNumber()
	end

	Slab.NewLine()

	Slab.Textf(
		"The SameLine function can also vertically center the next item based on the previous control. This is useful for labeling " ..
		"items that are much bigger than the text such as images.")
	Slab.Image('DrawCursor_Image', {Path = DrawImage_Path})
	Slab.SameLine({CenterY = true})
	Slab.Text("This text is centered with respect to the previous image.")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Slab offers functions to retrieve and set the cursor position. The GetCursorPos function will return the cursor position " ..
		"relative to the current window. An option can be passed to retrieve the absolute position of the cursor with respect " ..
		"to the viewport.")

	local X, Y = Slab.GetCursorPos()
	Slab.Text("Cursor X: " .. X)
	Slab.SameLine()
	Slab.Text("Cursor Y: " .. Y)

	local AbsX, AbsY = Slab.GetCursorPos({Absolute = true})
	Slab.Text("Absolute X: " .. AbsX)
	Slab.SameLine()
	Slab.Text("Absolute Y: " .. AbsY)

	if DrawCursor_X == nil then
		DrawCursor_X, DrawCursor_Y = Slab.GetCursorPos()
	end

	if Slab.Input('DrawCursor_X', {Text = tostring(DrawCursor_X), NumbersOnly = true, ReturnOnText = false}) then
		DrawCursor_X = Slab.GetInputNumber()
	end

	Slab.SameLine()

	if Slab.Input('DrawCursor_Y', {Text = tostring(DrawCursor_Y), NumbersOnly = true, ReturnOnText = false}) then
		DrawCursor_Y = Slab.GetInputNumber()
	end

	Slab.SetCursorPos(DrawCursor_X, DrawCursor_Y + 30.0)
	Slab.Text("Use the input fields to move this text.")
end

local DrawListBox_Basic_Selected = 1
local DrawListBox_Advanced_Selected = 1

local function DrawListBox()
	Slab.Textf(
		"A list box is a scrollable region that contains a list of elements that a user can interact with. The API is flexible " ..
		"so that each element in the list can be rendered in any way desired. Below are a few examples on different ways a list " ..
		"box can be used.")

	Slab.NewLine()

	Slab.BeginListBox('DrawListBox_Basic')
	for I = 1, 10, 1 do
		Slab.BeginListBoxItem('DrawListBox_Basic_Item_' .. I, {Selected = I == DrawListBox_Basic_Selected})
		Slab.Text("List Box Item " .. I)
		if Slab.IsListBoxItemClicked() then
			DrawListBox_Basic_Selected = I
		end
		Slab.EndListBoxItem()
	end
	Slab.EndListBox()

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Each list box can contain more than just text. Below is an example of list items with a triangle and a label.")

	Slab.NewLine()

	Slab.BeginListBox('DrawListBox_Advanced')
	local Rotation = 0
	for I = 1, 4, 1 do
		Slab.BeginListBoxItem('DrawListBox_Advanced_Item_' .. I, {Selected = I == DrawListBox_Advanced_Selected})
		Slab.Triangle({Radius = 24.0, Rotation = Rotation})
		Slab.SameLine({CenterY = true})
		Slab.Text("Triangle " .. I)
		if Slab.IsListBoxItemClicked() then
			DrawListBox_Advanced_Selected = I
		end
		Slab.EndListBoxItem()
		Rotation = Rotation + 90
	end
	Slab.EndListBox()
end

local DrawTree_Icon_Path = SLAB_PATH .. "/Internal/Resources/Textures/Folder.png"
local DrawTree_Opened_Selected = 1

local function DrawTree()
	Slab.Textf(
		"Trees allow data to be viewed in a hierarchy. Trees can also contain leaf nodes which have no children.")

	Slab.NewLine()

	if Slab.BeginTree('DrawTree_Root', {Label = "Root"}) then
		if Slab.BeginTree('DrawTree_Child_1', {Label = "Child 1"}) then
			Slab.BeginTree('DrawTree_Child_1_Leaf_1', {Label = "Leaf 1", IsLeaf = true})
			Slab.EndTree()
		end

		Slab.BeginTree('DrawTree_Leaf_1', {Label = "Leaf 2", IsLeaf = true})

		Slab.EndTree()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"The hot zone of a tree item starts at the expander and extends to the width of the window's content. " ..
		"This can be configured to only allow the tree item to be opened/closed with the expander.")

	Slab.NewLine()

	if Slab.BeginTree('DrawTree_Root_NoHighlight', {Label = "Root", OpenWithHighlight = false}) then
		Slab.BeginTree('DrawTree_Leaf', {Label = "Leaf", IsLeaf = true})
		Slab.EndTree()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Tree items can have an icon associated with them. A loaded Image object or path to an image can be " ..
		"specified.")

	Slab.NewLine()

	if Slab.BeginTree('DrawTree_Root_Icon', {Label = "Folder", IconPath = DrawTree_Icon_Path}) then
		Slab.BeginTree('DrawTree_Item_1', {Label = "Item 1", IsLeaf = true})
		Slab.BeginTree('DrawTree_Item_2', {Label = "Item 2", IsLeaf = true})

		if Slab.BeginTree('DrawTree_Child_1', {Label = "Folder", IconPath = DrawTree_Icon_Path}) then
			Slab.BeginTree('DrawTree_Item_3', {Label = "Item 3", IsLeaf = true})
			Slab.BeginTree('DrawTree_Item_4', {Label = "Item 4", IsLeaf = true})

			Slab.EndTree()
		end

		Slab.EndTree()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"A tree item can be specified to be forced open with the IsOpen option as shown in the example below. The example " ..
		"also shows how tree items can have the selection rectangle permanently rendered.")

	Slab.NewLine()

	if Slab.BeginTree('DrawTree_Root_Opened', {Label = "Root", IsOpen = true}) then
		for I = 1, 5, 1 do
			Slab.BeginTree('DrawTree_Item_' .. I, {Label = "Item " .. I, IsLeaf = true, IsSelected = I == DrawTree_Opened_Selected})

			if Slab.IsControlClicked() then
				DrawTree_Opened_Selected = I
			end
		end

		Slab.EndTree()
	end
end

local DrawDialog_MessageBox = false
local DrawDialog_MessageBox_Title = "Message Box"
local DrawDialog_MessageBox_Message = "This is a message."
local DrawDialog_FileDialog = ''
local DrawDialog_FileDialog_Result = ""

local function DrawDialog()
	Slab.Textf(
		"Dialog boxes are windows that rendered on top of everything else. These windows will consume input from all other windows " ..
		"and controls. These are useful for forcing users to interact with a window of importance, such as message boxes and " ..
		"file dialogs.")

	Slab.NewLine()

	Slab.Textf(
		"By clicking the button below, an example of a simple dialog box will be rendered.")
	if Slab.Button("Open Basic Dialog") then
		Slab.OpenDialog('DrawDialog_Basic')
	end

	if Slab.BeginDialog('DrawDialog_Basic', {Title = "Basic Dialog"}) then
		Slab.Text("This is a basic dialog box.")

		if Slab.Button("Close") then
			Slab.CloseDialog()
		end

		Slab.EndDialog()
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Slab offers support for common dialog boxes such as message boxes. To display a message box, Slab.MessageBox must be called every " ..
		"frame. The buttons to be drawn must be passed in through the Buttons option. Once the user has made a selection, the button that was " ..
		"clicked is returned and the program can handle the response accordingly.")

	Slab.NewLine()

	Slab.Text("Title")
	Slab.SameLine()
	if Slab.Input('DrawDialog_MessageBox_Title', {Text = DrawDialog_MessageBox_Title}) then
		DrawDialog_MessageBox_Title = Slab.GetInputText()
	end

	Slab.NewLine()

	Slab.Text("Message")
	if Slab.Input('DrawDialog_MessageBox_Message', {Text = DrawDialog_MessageBox_Message, MultiLine = true, H = 75}) then
		DrawDialog_MessageBox_Message = Slab.GetInputText()
	end

	Slab.NewLine()

	if Slab.Button("Show Message Box") then
		DrawDialog_MessageBox = true
	end

	if DrawDialog_MessageBox then
		local Result = Slab.MessageBox(DrawDialog_MessageBox_Title, DrawDialog_MessageBox_Message, {Buttons = {"OK"}})

		if Result ~= "" then
			DrawDialog_MessageBox = false
		end
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Slab offers a file dialog box so that user can select to open or save a file. This behaves similar to file dialogs found on " ..
		"various operating systems. Files can be filtered and a starting directory can be set. There are options for the user to select " ..
		"a single item or multiple items. As with the message box, the FileDialog option must be called every frame and the user response " ..
		"must be handled by the program.")

	Slab.NewLine()

	if Slab.Button("Open File") then
		DrawDialog_FileDialog = 'openfile'
	end

	Slab.SameLine()

	if Slab.Button("Open Directory") then
		DrawDialog_FileDialog = 'opendirectory'
	end

	Slab.SameLine()

	if Slab.Button("Save File") then
		DrawDialog_FileDialog = 'savefile'
	end

	if DrawDialog_FileDialog ~= '' then
		local Result = Slab.FileDialog({AllowMultiSelect = false, Type = DrawDialog_FileDialog})

		if Result.Button ~= "" then
			DrawDialog_FileDialog = ''

			if Result.Button == "OK" then
				DrawDialog_FileDialog_Result = Result.Files[1]
			end
		end
	end

	Slab.Textf(
		"Selected file: " .. DrawDialog_FileDialog_Result)
end

local DrawInteraction_MouseClicked_Left = 0
local DrawInteraction_MouseClicked_Right = 0
local DrawInteraction_MouseClicked_Middle = 0
local DrawInteraction_MouseReleased_Left = 0
local DrawInteraction_MouseReleased_Right = 0
local DrawInteraction_MouseReleased_Middle = 0
local DrawInteraction_MouseDoubleClicked_Left = 0
local DrawInteraction_MouseDoubleClicked_Right = 0
local DrawInteraction_MouseDoubleClicked_Middle = 0
local DrawInteraction_MouseVoidClicked_Left = 0
local DrawInteraction_KeyPressed_A = 0
local DrawInteraction_KeyPressed_S = 0
local DrawInteraction_KeyPressed_D = 0
local DrawInteraction_KeyPressed_F = 0
local DrawInteraction_KeyReleased_A = 0
local DrawInteraction_KeyReleased_S = 0
local DrawInteraction_KeyReleased_D = 0
local DrawInteraction_KeyReleased_F = 0

local function DrawInteraction()
	Slab.Textf(
		"Slab offers functions to query the user's input on a given frame. There are also functions to query for input on the most " ..
		"recently declared control. This can allow the implementation to use custom logic for controls to create custom behaviors.")

	Slab.NewLine()

	Slab.Textf(
		"Below are functions that query the state of the mouse. The IsMouseDown checks to see if a specific button is down on that " ..
		"frame. The IsMouseClicked will check to see if the state of a button went from up to down on that frame and the IsMouseReleased " ..
		"function checks to see if a button went from down to up on that frame.")

	local Left = Slab.IsMouseDown(1)
	local Right = Slab.IsMouseDown(2)
	local Middle = Slab.IsMouseDown(3)

	Slab.NewLine()

	Slab.Text("Left")
	Slab.SameLine()
	Slab.Text(Left and "Down" or "Up")

	Slab.Text("Right")
	Slab.SameLine()
	Slab.Text(Right and "Down" or "Up")

	Slab.Text("Middle")
	Slab.SameLine()
	Slab.Text(Middle and "Down" or "Up")

	Slab.NewLine()

	if Slab.IsMouseClicked(1) then DrawInteraction_MouseClicked_Left = DrawInteraction_MouseClicked_Left + 1 end
	if Slab.IsMouseClicked(2) then DrawInteraction_MouseClicked_Right = DrawInteraction_MouseClicked_Right + 1 end
	if Slab.IsMouseClicked(3) then DrawInteraction_MouseClicked_Middle = DrawInteraction_MouseClicked_Middle + 1 end

	if Slab.IsMouseReleased(1) then DrawInteraction_MouseReleased_Left = DrawInteraction_MouseReleased_Left + 1 end
	if Slab.IsMouseReleased(2) then DrawInteraction_MouseReleased_Right = DrawInteraction_MouseReleased_Right + 1 end
	if Slab.IsMouseReleased(3) then DrawInteraction_MouseReleased_Middle = DrawInteraction_MouseReleased_Middle + 1 end

	Slab.Text("Left Clicked: " .. DrawInteraction_MouseClicked_Left)
	Slab.SameLine()
	Slab.Text("Released: " .. DrawInteraction_MouseReleased_Left)

	Slab.Text("Right Clicked: " .. DrawInteraction_MouseClicked_Right)
	Slab.SameLine()
	Slab.Text("Released: " .. DrawInteraction_MouseReleased_Right)

	Slab.Text("Middle Clicked: " .. DrawInteraction_MouseClicked_Middle)
	Slab.SameLine()
	Slab.Text("Released: " .. DrawInteraction_MouseReleased_Middle)

	Slab.NewLine()

	Slab.Textf(
		"Slab offers functions to detect if the mouse was double-clicked or if a mouse button is being dragged.")

	Slab.NewLine()

	if Slab.IsMouseDoubleClicked(1) then DrawInteraction_MouseDoubleClicked_Left = DrawInteraction_MouseDoubleClicked_Left + 1 end
	if Slab.IsMouseDoubleClicked(2) then DrawInteraction_MouseDoubleClicked_Right = DrawInteraction_MouseDoubleClicked_Right + 1 end
	if Slab.IsMouseDoubleClicked(3) then DrawInteraction_MouseDoubleClicked_Middle = DrawInteraction_MouseDoubleClicked_Middle + 1 end

	Slab.Text("Left Double Clicked: " .. DrawInteraction_MouseDoubleClicked_Left)
	Slab.Text("Right Double Clicked: " .. DrawInteraction_MouseDoubleClicked_Right)
	Slab.Text("Middle Double Clicked: " .. DrawInteraction_MouseDoubleClicked_Middle)

	Slab.NewLine()

	local LeftDrag = Slab.IsMouseDragging(1)
	local RightDrag = Slab.IsMouseDragging(2)
	local MiddleDrag = Slab.IsMouseDragging(3)

	Slab.Text("Left Drag: " .. tostring(LeftDrag))
	Slab.Text("Right Drag: " .. tostring(RightDrag))
	Slab.Text("Middle Drag: " .. tostring(MiddleDrag))

	Slab.NewLine()

	Slab.Textf(
		"The mouse position relative to the viewport and relative to the current window can also be queried. Slab also offers retrieving " ..
		"the mouse delta.")

	Slab.NewLine()

	local X, Y = Slab.GetMousePosition()
	local WinX, WinY = Slab.GetMousePositionWindow()
	local DeltaX, DeltaY = Slab.GetMouseDelta()

	Slab.Text("X: " .. X .. " Y: " .. Y)
	Slab.Text("Window X: " .. WinX .. " Window Y: " .. WinY)
	Slab.Text("Delta X: " .. DeltaX .. " Delta Y: " .. DeltaY)

	Slab.Textf(
		"Slab also offers functions to test if the user is interacting with the non-UI layer. The IsVoidHovered and IsVoidClicked " ..
		"behave the same way as IsControlHovered and IsControlClicked except will only return true when it is in a non-UI area.")

	Slab.NewLine()

	if Slab.IsVoidClicked(1) then
		DrawInteraction_MouseVoidClicked_Left = DrawInteraction_MouseVoidClicked_Left + 1
	end

	local IsVoidHovered = Slab.IsVoidHovered()

	Slab.Text("Left Void Clicked: " .. DrawInteraction_MouseVoidClicked_Left)
	Slab.Text("Is Void Hovered: " .. tostring(IsVoidHovered))

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Slab offers functions to check for the state of a specific keyboard key. The key code to use are the ones defined by LÖVE " ..
		"which can be found on the wiki. Below we will check for the key states of the A, S, D, F keys.")

	Slab.NewLine()

	local IsDown_A = Slab.IsKeyDown('a')
	local IsDown_S = Slab.IsKeyDown('s')
	local IsDown_D = Slab.IsKeyDown('d')
	local IsDown_F = Slab.IsKeyDown('f')

	if Slab.IsKeyPressed('a') then DrawInteraction_KeyPressed_A = DrawInteraction_KeyPressed_A + 1 end
	if Slab.IsKeyPressed('s') then DrawInteraction_KeyPressed_S = DrawInteraction_KeyPressed_S + 1 end
	if Slab.IsKeyPressed('d') then DrawInteraction_KeyPressed_D = DrawInteraction_KeyPressed_D + 1 end
	if Slab.IsKeyPressed('f') then DrawInteraction_KeyPressed_F = DrawInteraction_KeyPressed_F + 1 end

	if Slab.IsKeyReleased('a') then DrawInteraction_KeyReleased_A = DrawInteraction_KeyReleased_A + 1 end
	if Slab.IsKeyReleased('s') then DrawInteraction_KeyReleased_S = DrawInteraction_KeyReleased_S + 1 end
	if Slab.IsKeyReleased('d') then DrawInteraction_KeyReleased_D = DrawInteraction_KeyReleased_D + 1 end
	if Slab.IsKeyReleased('f') then DrawInteraction_KeyReleased_F = DrawInteraction_KeyReleased_F + 1 end

	Slab.Text("A Down: " .. tostring(IsDown_A))
	Slab.Text("S Down: " .. tostring(IsDown_S))
	Slab.Text("D Down: " .. tostring(IsDown_D))
	Slab.Text("F Down: " .. tostring(IsDown_F))

	Slab.NewLine()

	Slab.Text("A Pressed: " .. DrawInteraction_KeyPressed_A)
	Slab.Text("S Pressed: " .. DrawInteraction_KeyPressed_S)
	Slab.Text("D Pressed: " .. DrawInteraction_KeyPressed_D)
	Slab.Text("F Pressed: " .. DrawInteraction_KeyPressed_F)

	Slab.NewLine()

	Slab.Text("A Released: " .. DrawInteraction_KeyReleased_A)
	Slab.Text("S Released: " .. DrawInteraction_KeyReleased_S)
	Slab.Text("D Released: " .. DrawInteraction_KeyReleased_D)
	Slab.Text("F Released: " .. DrawInteraction_KeyReleased_F)
end

function SlabTest.MainMenuBar()
	if Slab.BeginMainMenuBar() then
		if Slab.BeginMenu("File") then
			if Slab.MenuItem("Quit") then
				love.event.quit()
			end

			Slab.EndMenu()
		end

		SlabDebug.Menu()

		Slab.EndMainMenuBar()
	end
end

local Categories = {
	{"Overview", DrawOverview},
	{"Buttons", DrawButtons},
	{"Text", DrawText},
	{"Check Box", DrawCheckBox},
	{"Radio Button", DrawRadioButton},
	{"Menus", DrawMenus},
	{"Combo Box", DrawComboBox},
	{"Input", DrawInput},
	{"Image", DrawImage},
	{"Cursor", DrawCursor},
	{"List Box", DrawListBox},
	{"Tree", DrawTree},
	{"Dialog", DrawDialog},
	{"Interaction", DrawInteraction}
}

local Selected = nil

function SlabTest.Begin()
	SlabTest.MainMenuBar()

	if Selected == nil then
		Selected = Categories[1]
	end

	Slab.BeginWindow('Main', {Title = "Slab", AutoSizeWindow = false, W = 800.0, H = 600.0})

	local W, H = Slab.GetWindowActiveSize()

	if Slab.BeginComboBox('Categories', {Selected = Selected[1], W = W}) then
		for I, V in ipairs(Categories) do
			if Slab.TextSelectable(V[1]) then
				Selected = Categories[I]
			end
		end

		Slab.EndComboBox()
	end

	Slab.Separator()

	if Selected ~= nil and Selected[2] ~= nil then
		Selected[2]()
	end

	Slab.EndWindow()

	SlabDebug.Begin()
end

return SlabTest
