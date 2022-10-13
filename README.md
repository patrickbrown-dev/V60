# Kisoku (<ruby>規則<rt>きそく</rt></ruby>)

A Rules Engine gem.

## About

Rules Engines are a useful pattern when you need to apply conditional rules to an input, and you don't care about the order (in other words, the operations have the associative mathematical property). A couple notable examples are search filtering and calculating percentage discounts.

## Example 1: Filtering Book Product IDs by properties.

Let's say we have a collection of product IDs for books that we want the user to be able to filter (for example, by genre, or having a minimum raiting of 4.0 stars). We can codify each of these filters as a `Kisoku::Rule` and apply filtering by query parameters.

```ruby
class RatingGreaterThanRule < Kisoku::Rule
  def condition(params)
    params.include?(:rating_greater_than)
  end

  def action(product_ids, params)
    product_ids.select do |product_id|
      get_rating(product_id) > params[:rating_greater_than]
    end
  end

  private

  def get_rating(product_id)
    # This could be a database lookup, or an HTTP GET to a RESTful service!
  end
end
```

```ruby
class GenreFilterRule < Kisoku::Rule
  def condition(params)
    params.include?(:genre)
  end

  def action(product_ids, params)
    product_ids.select do |product_id|
      get_genre(product_id) == params[:genre]
    end
  end

  private

  def get_genre(product_id)
    # This could be a database lookup, or an HTTP GET to a RESTful service!
  end
end
```

