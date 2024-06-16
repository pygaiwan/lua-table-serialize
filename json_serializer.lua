local json_serializer = {}

local function basic_serialize(value)
    return string.format("%q", value)
end

local function to_json(o, text, indent)
    text = text or ''
    indent = indent or 0
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        text = text .. basic_serialize(o)
    elseif t == "table" then
        local is_list = #o > 0
        local open_par, close_par

        if is_list then
            open_par, close_par = "[", "]"
        else
            open_par, close_par = "{", "}"
        end

        text = text .. open_par .. "\n"
        indent = indent + 1
        local spaces = ('  '):rep(indent)
        local first_elem = true
        if is_list then
            for _, v in ipairs(o) do
                if not first_elem then text = text .. ",\n" end
                first_elem = false
                text = text .. spaces
                text = to_json(v, text, indent)
            end
        else
            for k, v in pairs(o) do
                if not first_elem then text = text .. ',\n' end
                first_elem = false
                text = text .. spaces .. '"' .. k .. '": '
                text = to_json(v, text, indent)
            end
        end
        indent = indent - 1
        spaces = ('  '):rep(indent)
        text = text .. "\n" .. spaces .. close_par
    else
        error("cannot serialize a " .. t)
    end
    return text
end

json_serializer.to_json = to_json
return json_serializer
