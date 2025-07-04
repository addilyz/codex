local dna = {}
local props = {}
local cases = {}
function dna.add(arg,case)
	local ti = table.insert
	ti(props,arg)
	ti(cases,case)
end
function dna.scan(ms,arg,b)
	if ms~=arg then
		cases[b](ms)
		return true
	end
end
function dna.sweep(args)
	local tf = false
	local ss = string.gsub
	for a=1, #args, 1 do
		for b=1, #props, 1 do
			tf = dna.scan(ss(args[a],props[b],""),args[a],b)
		end
	end
	return tf
end
function dna.getNoTicks(args)
	local t = {}
	for n=1, #args, 1 do
		if string.gsub(args[n],"-","") == args[n] then
			t[#t+1] = args[n]
		end
	end
	return t
end
return dna
