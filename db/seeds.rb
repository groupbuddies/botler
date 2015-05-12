[
  'Communication',
  'Meals',
  'Travel',
  'Services',
  'Space Rentals',
  'Equipment',
  'Consumables',
  'Training',
  'Human Resources'
].each do |category_name|
  Category.where(name: category_name).first_or_create
end
