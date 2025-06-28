
local sugar = {}
local y = {}
local dna = require(CODEX_PATH.."/dynamicArgs")
local tf = false
local uptime = 0
local bootloader = "bits"
local blargs = {}

function sugar.load(args)
	tf = dna.sweep(args)
	blargs = dna.getNoTicks(args)
end

function sugar.bootloader(reqAddr)
	bootloader = reqAddr
end

function sugar.update(dt)
	uptime=uptime+dt
	if uptime > .1 then
		if tf == false then
			local bl = require(bootloader)
			codex.add("bootloader",bl)
			if type(bl.load) ~= "nil" then
				bl.load()
			end
		end
		codex.remove("sugar")
	end
end

codex.add("sugar",sugar)
