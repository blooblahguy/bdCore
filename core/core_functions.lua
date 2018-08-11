local bdCore, c, f = select(2, ...):unpack()

-- also comma values
function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
-- not crazy about the built in split function
function split(str, del)
	local t = {}
	local index = 0;
	while (string.find(str, del)) do
		local s, e = string.find(str, del)
		t[index] = string.sub(str, 1, s-1)
		str = string.sub(str, s+#del)
		index = index + 1;
	end
	table.insert(t, str)
	return t;
end

-- lua doesn't have a good function for round
function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

-- lua doesn't have a good function for finding a value in a table
function in_table ( e, t )
	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end