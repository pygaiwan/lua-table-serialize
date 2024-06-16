my_json = require("json_serializer")

describe("Simple table elements parsed correctly:\n", function()
    local _json = require("dkjson")

    it("boolean entry", function()
        local input = { a = true }
        local expected = [[{
  "a": true
}]]
        assert.are.same(_json.decode(expected), _json.decode(my_json.to_json(input)))
    end)

    it("string entry", function()
        local input = { a = "a" }
        local expected = [[{
  "a": "a"
}]]
        assert.are.same(_json.decode(expected), _json.decode(my_json.to_json(input)))
    end)

    it("list entry", function()
        local input = { a = { 1, 2, 3 } }
        local expected = [[{
  "a": [1, 2, 3]
}]]
        assert.are.same(_json.decode(expected), _json.decode(my_json.to_json(input)))
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
        assert.are.same(_json.decode(expected), _json.decode(my_json.to_json(input)))
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
        assert.are.same(_json.decode(expected), _json.decode(my_json.to_json(input)))
    end)
end)
