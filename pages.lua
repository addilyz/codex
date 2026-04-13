local pages = {}
local adds = {}

function pages.draw()
	for n = 1, #adds, 1 do
		for k, v in next, pages[adds[n]] do
			v()
		end
	end
end

function pages.getPage(number)
	if pages[number] == nil then
		return pages.newPage(number)
	else
		return pages[number]
	end
end

function pages.newPage(number)
	for n = 1, #adds, 1 do
		if adds[n] > number then
			table.insert(adds,n,number)
			pages[number] = {}
			return pages[number]
		end
	end
	table.insert(adds,number)
	pages[number] = {}
	return pages[number]
end

function pages.expunge(key)
	for n = 1, #adds, 1 do
		if pages[adds[n]][key] ~= nil then pages[adds[n]][key] = nil end
	end
end

function pages.crumple(pagenum) -- probably bad to use this function idk i didn't write it for any reason.
	pages[pagenum] = {}
end

function pages.funcAtKeyInPage(func, key, pagenumber) -- if scope is uncomfortable.
	local a = pages.getPage(pagenumber)
	a[key] = func
end

return pages