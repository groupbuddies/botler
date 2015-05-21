window.Categories = (function() {

  function initialize(categories, subcategories) {
    var $categories = categories;
    var $subcategories = subcategories;

    $categories.on('change', onCategoryChange);
    
    function onCategoryChange(event) {
      $subcategories.empty();
      $subcategories.append(document.createElement('option'));
      $.ajax({
        dataType: 'json',
        url: '/api/categories/' + $categories.val(),
        success: updateSubcategories
      });
    }

    function updateSubcategories(data) {
      $.each(data.subcategories, addSubcategory);
    }

    function addSubcategory(index, subcategory) {
      var option = document.createElement('option');

      option.text = subcategory.name;
      option.value = subcategory.id;

      $subcategories.append(option);
    }
  }

  return {
    initialize: initialize
  }

})();
