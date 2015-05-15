{
  'Communication' => ['Vodafone'],
  'Meals' => ['Lunch/Dinner', 'Other Meals'],
  'Travel' => ['Flight', 'Train'],
  'Services' => ['Software', 'Accountancy', 'Marketing', 'Other Services'],
  'Space Rentals' => ['Office', 'Accommodation', 'Other Space Rentals'],
  'Equipment' => ['IT Equipment', 'Other Equipment'],
  'Consumables' => ['Office Supplies', 'Other Consumables'],
  'Training' => ['Conferences', 'Workshops', 'Books'],
  'Human Resources' => ['Salary', 'Food Allowance']
}.each do |parent, subcategories|
  parent = Category.where(name: parent).first_or_create
  subcategories.each do |subcategory|
    subcategory = Category.where(name: subcategory).first_or_create
    subcategory.update!(parent: parent)
  end
end
