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
	end
end
function dna.sweep(args)
	local ss = string.sub
	for a=1, #args, 1 do
		for b=1, #props, 1 do
			dna.scan(ss(args[a],props[b],""),args[a],b)
		end
	end
end
return dna