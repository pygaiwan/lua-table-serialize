Small utility (and learning exercise) to visualize Lua tables in JSON or "dot" notion to represent how you can access values of a table.

..  code-block:: lua

  my_pkg = require('json_serializer')
  
  data = { a = 'a', b = 'b', c = {1, 2, 3}, d = { x1 = 'x1', x2 = 'x2' } }
  
  print('JSON Notation\n')
  print(my_pkg.to_json(data))
  
  
  print('\n\ndot Notation\n')
  print(my_pkg.pprint(data, 'data'))
