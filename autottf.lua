--- love2d automatic table to file
local function filer(t,fn)
	local loc = 0
	local cat = "nil"
	local n = "\n"
local function ttfrecursive(t,fn)
	local loc = 0
	local cat = "nil"
	local n = "\n"
	while loc < #t do
		loc = loc + 1
		cat = type(t[loc])
		if cat == "table" then love.filesystem.append(fn,n.."{") ttfrecursive(t[loc],fn) end
		if cat == "string" then love.filesystem.append(fn,'"'..t[loc]..'"') end
		if cat == "number" then love.filesystem.append(fn,tostring(t[loc])) end
		if loc == #t then 
			love.filesystem.append(fn,"}")
		else
			love.filesystem.append(fn,", ")
		end
	end
end
	love.filesystem.write(fn,"local t = {")
	while loc < #t do
		loc = loc + 1
		cat = type(t[loc])
		if cat == "table" then love.filesystem.append(fn,n.."{") ttfrecursive(t[loc],fn) end 
		if cat == "string" then love.filesystem.append(fn,'"'..t[loc]'"') end
		if cat == "number" then love.filesystem.append(fn,tostring(t[loc])) end
		if loc == #t then 
			love.filesystem.append(fn,"}"..n..n.."return t")
		else
			love.filesystem.append(fn,", ")
		end
	end
end


return filer