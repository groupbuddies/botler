module CategoryRepresenter
  include Roar::JSON
  include Roar::Hypermedia

  property :name

  collection :subcategories, class: Category, embedded: true do
    property :name
  end

  link :self do
    api_category_url self
  end
end
