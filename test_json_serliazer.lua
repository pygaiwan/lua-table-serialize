my_pkg = require("json_serializer")

describe("Testing of to_json:\n", function()
    describe("Simple table elements parsed correctly:\n", function()
        local _json = require("dkjson")

        it("boolean entry", function()
            local input = { a = true }
            local expected = [[{
      "a": true
    }]]
            assert.are.same(_json.decode(expected), _json.decode(my_pkg.to_json(input, '', 0)))
        end)

        it("string entry", function()
            local input = { a = "a" }
            local expected = [[{
      "a": "a"
    }]]
            assert.are.same(_json.decode(expected), _json.decode(my_pkg.to_json(input, '', 0)))
        end)

        it("list entry", function()
            local input = { a = { 1, 2, 3 } }
            local expected = [[{
      "a": [1, 2, 3]
    }]]
            assert.are.same(_json.decode(expected), _json.decode(my_pkg.to_json(input, '', 0)))
        end)

        it("table entry", function()
            local input = { a = { b = 1, c = 2, d = 3 } }
            local expected = [[{
      "a": {
        "b": 1,
        "c": 2,
        "d": 3
      }
    }]]
            assert.are.same(_json.decode(expected), _json.decode(my_pkg.to_json(input, '', 0)))
        end)
    end)


    describe("Nested table elements parsed correctly:\n:", function()
        local _json = require("dkjson")
        it("Something", function()
            local input = { a = { b = { c = 1, c2 = "1a" }, d = 2 } }
            local expected = [[{
      "a": {
        "b": {
          "c": 1,
          "c2": "1a"
        },
        "d": 2
      }
    }]]
            assert.are.same(_json.decode(expected), _json.decode(my_pkg.to_json(input, '', 0)))
        end)
    end)
end)


describe("Testing of pprint:\n", function()
    describe("Simple table elements parsed correctly:\n", function()
        local function split_lines(s)
            local lines = {}
            for line in s:gmatch("([^\n]*)\n?") do
                if line ~= "" then
                    table.insert(lines, line)
                end
            end
            return lines
        end
        it("boolean entry", function()
            local input = { a = 1 }
            local expected = [[input.a = 1
]]

            assert.are.same(my_pkg.pprint(input, "input"), expected)
        end)
        it("string entry", function()
            local input = { a = "a" }
            local expected = [[input.a = "a"
]]

            assert.are.same(my_pkg.pprint(input, "input"), expected)
        end)
        it("table entry", function()
            local input = { a = { b = 1, c = 2, d = 3 } }
            local expected = [[input.a.b = 1
input.a.c = 2
input.a.d = 3
]]
            local result = my_pkg.pprint(input, "input")
            local result_lines = split_lines(result)
            local expected_lines = split_lines(expected)

            table.sort(result_lines)
            table.sort(expected_lines)

            assert.are.same(result_lines, expected_lines)
        end)
    end)
end)
