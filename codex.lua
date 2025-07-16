if type(CODEX_PATH) == "nil" then CODEX_PATH = "codex" end
codex = {
	draw = {},
	errhand = {love = love.errhand},
	errorhandler = {love = love.errorhandler},
	load = {},
	lowmemory = {},
	threaderror = {},
	update = {},
	directorydropped = {},
	displayrotated = {},
	filedropped = {},
	focus = {},
	mousefocus = {},
	resize = {},
	visible = {},
	keypressed = {},
	keyreleased = {},
	textedited = {},
	textinput = {},
	mousemoved = {},
	mousepressed = {},
	mousereleased = {},
	wheelmoved = {},
	gamepadaxis = {},
	gamepadpressed = {},
	gamepadreleased = {},
	joystickadded = {},
	joystickaxis = {},
	joystickhat = {},
	joystickpressed = {},
	joystickreleased = {},
	joystickremoved = {},
	touchmoved = {},
	touchpressed = {},
	touchreleased = {}
}
function codex.handle(name,a,b,c,d,e,f)
	for k, v in next, codex[name] do
		v(a,b,c,d,e,f)
	end
end
function codex.delete(key)
	if type(key) == "table" and #key == 1 then
		key = key[1]
	end
	if type(key) ~= "table" then
		for k, v in next, codex do
			if type(v) == "table" then
				v[key] = nil
			end
		end
	else
		for n = 1, #key, 1 do
			for k, v in next, codex do
				if type(v) == "table" then
					v[key[n]] = nil
				end
			end
		end
	end
end
function codex.add(key,tab)
	for k, v in next, tab do
		if type(codex[k]) == "table" then codex[k][key]=v end
	end
end
local lg = love.graphics
local le = love.event
local lt = love.timer
function love.run()
	codex.handle("load",love.arg.parseGameArguments(arg), arg)
	local dt = 0
	return function()
		if le then
			le.pump()
			for name, a,b,c,d,e,f in le.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				codex.handle(name,a,b,c,d,e,f)
			end
		end
		if lt then dt = lt.step() end
		codex.handle("update",dt)
		if lg and lg.isActive() then
			lg.origin()
			lg.clear(lg.getBackgroundColor())
			codex.pages.draw()
			lg.present()
		end
		if lt then lt.sleep(0.001) end
	end
end
codex.pages = require(CODEX_PATH .. "/pages")
