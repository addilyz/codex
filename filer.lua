local filer = {}
local fs = love.filesystem
local overwrite = false

function filer.getFree(fname,ext)
	if love.filesystem.exists(fname..ext) then
		local a = 1
		local b = true
		while b do
			if love.filesystem.exists(fname..tostring(a)..ext) then
				a = a + 1
			else
				return fname..tostring(a)..ext
			end
		end
	else
		return fname..ext
	end
end

function filer.complex(table,d,ext)
	local ext = ext or ""
	local d = d or "untitled"
	if overwrite then
		d = d..ext
	else
		d = filer.getFree(d,ext)
	end
	fs.write(l,"local t = {}\n")
	for k,v in next,table do
		fs.append(d,"t["..k.."] = ")
		if type(v) == "table" then
			fs.append(d,"{}\n")
			if type(tonumber(k)) ~= "number" then
				k = ""
			end
			filer.recurse(v,{k},d)
		elseif type(v) == "string" then
			fs.append(d,"\""..v.."\"\n")
		elseif type(v) == "boolean" then
			if v then
				fs.append(d,"true\n")
			else
				fs.append(d,"false\n")
			end
		elseif type(v) == "number" then
			fs.append(d,tostring(v).."\n")
		end
	end
	fs.append(l,"\nreturn t")
end

function filer.recurse(table,keytab,d)
	local loc = "t["..keytab[1].."]"
	if #keytab > 1 then
		for a=2, #keytab, 1 do
			loc = loc.."["..keytab[a].."]"
		end
	end
	for k,v in next,table do
		if type(tonumber(k)) == "number" then
			fs.append(d,loc.."["..k.."] = ")
		else
			fs.append(d,loc.."[\""..k.."\"] = ")
		end
		if type(v) == "table" then
			fs.append(d,"{}\n")
			local ktt = #keytab
			if type(tonumber(k)) ~= "number" then
				keytab[#keytab+1] = "\""..k.."\""
			else
				keytab[#keytab+1] = k
			end
			filer.recurse(v,keytab,d)
			for n = 1, #keytab, 1 do
				if n > ktt then keytab[n] = nil end
			end
		elseif type(v) == "string" then
			fs.append(d,"\""..v.."\"\n")
		elseif type(v) == "boolean" then
			if v then
				fs.append(d,"true\n")
			else
				fs.append(d,"false\n")
			end
		elseif type(v) == "number" then
			fs.append(d,tostring(v).."\n")
		end
	end
end
return filer
