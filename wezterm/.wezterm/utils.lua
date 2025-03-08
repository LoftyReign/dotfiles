local Utils = {}

function Utils:split_string(inputstr, sep)
	print("File in split: " .. inputstr)

	if sep == nil then
		sep = "%s"
	end

	local t = {}

	print(inputstr)
	print(sep)

	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

return Utils
