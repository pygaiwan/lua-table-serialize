Small utility (and learning exercise) to visualize Lua tables in JSON or "dot" notion to represent how you can access values of a table.

..  code-block:: lua

  my_pkg = require('json_serializer')
  
  data = { a = 'a', b = 'b', c = {1, 2, 3}, d = { x1 = 'x1', x2 = 'x2' } }
  
  print('JSON Notation\n')
  print(my_pkg.to_json(data))

.. code-block::

  JSON Notation
  
  {
    "b": "b",
    "c": [
      1,
      2,
      3
    ],
    "d": {
      "x1": "x1",
      "x2": "x2"
    },
    "a": "a"
  }

..  code-block:: lua

  my_pkg = require('json_serializer')
  
  data = { a = 'a', b = 'b', c = {1, 2, 3}, d = { x1 = 'x1', x2 = 'x2' } }

  print('dot Notation\n')
  print(my_pkg.pprint(data, 'data'))

.. code-block:: 

  dot Notation

  data.b = "b"
  data.c.1 = 1
  data.c.2 = 2
  data.c.3 = 3
  data.d.x1 = "x1"
  data.d.x2 = "x2"
  data.a = "a"

