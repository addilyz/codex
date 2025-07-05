
local sugar = {}
local y = {}
sugar.dna = require(CODEX_PATH.."/dna")
local dna = sugar.dna
local tf = false
local uptime = 0
local bootloader = "bits"
local blargs = {}
local lg = love.graphics
local lw = love.window
local windim = {600,800}
local mobile = false
love.graphics.setBackgroundColor(1,1,1)

function sugar.load(args)
	tf = dna.sweep(args)
	blargs = dna.getNoTicks(args)
end

function sugar.bootloader(reqAddr)
	bootloader = reqAddr
end

function sugar.setResolution(x,y)
	windim = {x,y}
end

function sugar.update(dt)
	uptime=uptime+dt
	if uptime > .1 then
		if lg.getWidth()>9 then mobile = true else 
			lw.setMode(windim[1],windim[2])
		end
	end
	if uptime > .2 then
		if tf == false then
			print(bootloader)
			local bl = require(bootloader)
			codex.add("bootloader",bl)
			if type(bl.load) ~= "nil" then
				bl.load(blargs)
			end
		end
		codex.delete("sugar")
	end
end

codex.add("sugar",sugar)
return sugar