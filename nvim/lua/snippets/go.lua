local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {}

-- Go function with error handling
snippets.go_func = snippet("func", {
  text_node("func "),
  insert_node(1, "name"),
  text_node("("),
  insert_node(2, "params"),
  text_node(") "),
  insert_node(3, "return_type"),
  text_node(" {"),
  text_node({"", "\t"}),
  insert_node(4, "// implementation"),
  text_node({"", "}"}),
})

-- Go interface
snippets.go_interface = snippet("interface", {
  text_node("type "),
  insert_node(1, "Name"),
  text_node(" interface {"),
  text_node({"", "\t"}),
  insert_node(2, "Method() Type"),
  text_node({"", "}"}),
})

-- Go struct
snippets.go_struct = snippet("struct", {
  text_node("type "),
  insert_node(1, "Name"),
  text_node(" struct {"),
  text_node({"", "\t"}),
  insert_node(2, "Field Type"),
  text_node({"", "}"}),
})

-- Go error handling
snippets.go_err = snippet("err", {
  text_node("if err != nil {"),
  text_node({"", "\t"}),
  insert_node(1, "return err"),
  text_node({"", "}"}),
})

-- Go method
snippets.go_method = snippet("method", {
  text_node("func ("),
  insert_node(1, "receiver"),
  text_node(" "),
  insert_node(2, "Type"),
  text_node(") "),
  insert_node(3, "Method"),
  text_node("("),
  insert_node(4, "params"),
  text_node(") "),
  insert_node(5, "return_type"),
  text_node(" {"),
  text_node({"", "\t"}),
  insert_node(6, "// implementation"),
  text_node({"", "}"}),
})

-- Go test function
snippets.go_test = snippet("test", {
  text_node("func Test"),
  insert_node(1, "Name"),
  text_node("(t *testing.T) {"),
  text_node({"", "\t"}),
  insert_node(2, "// test implementation"),
  text_node({"", "}"}),
})

-- Go main function
snippets.go_main = snippet("main", {
  text_node("func main() {"),
  text_node({"", "\t"}),
  insert_node(1, "// main implementation"),
  text_node({"", "}"}),
})

-- Go package main
snippets.go_package_main = snippet("package_main", {
  text_node("package main"),
  text_node({"", "", "import (", "\t"}),
  insert_node(1, '"fmt"'),
  text_node({"", ")", "", "func main() {", "\t"}),
  insert_node(2, 'fmt.Println("Hello, World!")'),
  text_node({"", "}"}),
})

-- Go for loop
snippets.go_for = snippet("for", {
  text_node("for "),
  insert_node(1, "i := 0; i < 10; i++"),
  text_node(" {"),
  text_node({"", "\t"}),
  insert_node(2, "// loop body"),
  text_node({"", "}"}),
})

-- Go range loop
snippets.go_range = snippet("range", {
  text_node("for "),
  insert_node(1, "i, v"),
  text_node(" := range "),
  insert_node(2, "slice"),
  text_node(" {"),
  text_node({"", "\t"}),
  insert_node(3, "// range body"),
  text_node({"", "}"}),
})

-- Go select statement
snippets.go_select = snippet("select", {
  text_node("select {"),
  text_node({"", "case "}),
  insert_node(1, "msg := <-ch"),
  text_node(":"),
  text_node({"", "\t"}),
  insert_node(2, "// handle msg"),
  text_node({"", "default:", "\t"}),
  insert_node(3, "// default case"),
  text_node({"", "}"}),
})

-- Go HTTP handler
snippets.go_http_handler = snippet("handler", {
  text_node("func "),
  insert_node(1, "handler"),
  text_node("(w http.ResponseWriter, r *http.Request) {"),
  text_node({"", "\t"}),
  insert_node(2, "// handler implementation"),
  text_node({"", "}"}),
})

-- Go goroutine
snippets.go_goroutine = snippet("go", {
  text_node("go func() {"),
  text_node({"", "\t"}),
  insert_node(1, "// goroutine implementation"),
  text_node({"", "}()"}),
})

-- Go defer statement
snippets.go_defer = snippet("defer", {
  text_node("defer func() {"),
  text_node({"", "\t"}),
  insert_node(1, "// cleanup code"),
  text_node({"", "}()"}),
})

-- Go channel
snippets.go_channel = snippet("chan", {
  text_node("make(chan "),
  insert_node(1, "string"),
  insert_node(2, ", 1"),
  text_node(")"),
})

-- Go map
snippets.go_map = snippet("map", {
  text_node("make(map["),
  insert_node(1, "string"),
  text_node("]"),
  insert_node(2, "string"),
  text_node(")"),
})

-- Go slice
snippets.go_slice = snippet("slice", {
  text_node("make([]"),
  insert_node(1, "string"),
  text_node(", "),
  insert_node(2, "0"),
  text_node(", "),
  insert_node(3, "10"),
  text_node(")"),
})

-- Register snippets for Go filetype
local luasnip = require('luasnip')
for _, snippet in pairs(snippets) do
  luasnip.add_snippets('go', { snippet })
end

return snippets
