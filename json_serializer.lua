local json_serializer = {}

---Format basic values.
---@param value any
---@return string
local function basic_serialize(value)
    return string.format("%q", value)
end

---Serialize to JSON compatible format a table.
---@param o any
---@param text string  "Starts to empty."
---@param indent integer "Indentation used, empty to 0."
---@return string "Value of text after serialization"
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

local function pprint(o, name, text, root)
    text = text or ''
    root = root or name
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        text = text .. root .. ' = ' .. basic_serialize(o) .. '\n'
    elseif t == "table" then
        for k, v in pairs(o) do
            local new_root = root .. '.' .. k 
            text = pprint(v, k, text, new_root)
        end
    else
        error("cannot serialize a " .. t)
    end
    return text
end

json_serializer.to_json = to_json
json_serializer.pprint = pprint
return json_serializer
