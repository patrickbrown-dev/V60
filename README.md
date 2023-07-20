# V60

A Rules Engine gem named after the Hario V60 coffee dripper. It's goal is to
enable developers to efficiently filter large sets of data without creating a
nest of `if` statements.

⚠️ This gem is still in development and is not ready for production use. ⚠️

## Features

- Gives the developer "building blocks" of filters to be combined in any way.
- All reducers are associative and commutative, so they are run in parallel.
- No external dependencies.

## Limitations

- Only supports `Set` as the input data structure.

## A Simple Example

```ruby
require "v60"

set = Set.new(
  [
    {
      title: "Cheap Scary Book",
      genre: :horror,
      price: 9_99
    },
    {
      title: "Expensive Scary Book",
      genre: :horror,
      price: 17_99
    },
    {
      title: "Cheap Sad Book",
      genre: :literary_fiction,
      price: 8_99
    },
    {
      title: "Cheap Thrilling Book",
      genre: :thriller,
      price: 6_99
    }
  ]
)

engine = V60::Engine.new(
  [
    V60::Filters::LessThanOrEqualTo.new(key: :price, value: 10_00),
    V60::Filters::In.new(key: :genre, value: [:horror, :thriller])
  ],
  V60::Reducers::Sum.new(field: :price)
)

engine.run(set) # => 16_98
```
