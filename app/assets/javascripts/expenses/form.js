window.ExpensesForm = (function() {

  function initialize() {
    var $container = $('.expenses-form');
    var $vat = $('#expense_vat', $container);
    var $amount = $('#expense_amount', $container);
    var $computedAmount = $('#computed-amount p', $container);

    $amount.on('keyup change', onAmountChange);
    $vat.on('keyup change', onAmountChange);

    var $categories = $('#main_category');
    var $subcategories = $('#expense_category_id');
    window.Categories.initialize($categories, $subcategories);

    function onAmountChange(event) {
      var value = parseFloat($amount.val()) || 0;
      var vat = parseFloat($vat.val()) || 0;
      var computed = value + (value * (vat / 100));
      updateComputedAmount(computed);
    }

    function updateComputedAmount(newAmount) {
      $computedAmount.text('€' + newAmount.toFixed(2));
    }
  }

  return {
    initialize: initialize
  };

})();
