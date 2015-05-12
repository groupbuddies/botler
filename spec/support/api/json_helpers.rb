module API
  module JSONHelpers
    def json_response
      JSON.parse(page.body)
    end

    def map_json_attribute(collection, attribute_name)
      collection.map { |resource| resource[attribute_name.to_s] }.compact
    end

    def link_for_rel(resource, rel)
      resource['links'].find { |link| link['rel'] == rel }['href']
    end
  end
end
