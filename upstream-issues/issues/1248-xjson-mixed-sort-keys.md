title: xjson.extract_numbers and xjson.sort raise TypeError on mixed number/text keys
labels: bug,tools,good first issue
upstream: 1248

As of openXC7/prjxray 6dabf706, `prjxray/xjson.py:18` `extract_numbers()` returns a tuple that starts with an int or a str depending on the input. Comparing two such tuples fails when one string starts with a digit and the other does not. Tested against the current file:

```
>>> extract_numbers("A100") > extract_numbers("100B")
TypeError: '>' not supported between instances of 'str' and 'int'
>>> sort({"A100": 1, "100B": 2})
TypeError: '<' not supported between instances of 'int' and 'str'
```

`sort()` uses `extract_numbers()` as its key (`prjxray/xjson.py:62-74`), so any JSON written through `xjson.pprint` with such keys fails.

### Suggested fix
- Make each element of the key type-tagged, for example `(0, n)` for numbers and `(1, s)` for text, so mixed tuples always compare.
- Add doctests for the case above, for `sort()` on a dict with mixed keys, and keep the existing ones passing.

Imported from f4pga/prjxray#1248, opened by litghost in 2020.
