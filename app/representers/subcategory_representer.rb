module SubcategoryRepresenter
  include Roar::JSON
  include Roar::Hypermedia

  property :id
  property :name

  link :self do
    api_category_url self
  end
end
