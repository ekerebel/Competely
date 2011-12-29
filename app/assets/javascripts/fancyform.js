jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery(function($) {
  $("#unspsc_sform > #segment").ready(function() {
  		$("#unspsc_form > #segment").change();
  	});
  // when the #segment/family/class field changes
  $("#unspsc_form > #segment").change(function() {
    // make a POST call and replace the content
    var segment = $('#unspsc_form > #segment :selected').val();
    var defaultCategory=$('#default_family').val();
    if(segment == "") segment="0";
    jQuery.get('/products/update_category_select/' + segment,{type:"family", divId:"unspsc_form", defaultCategory:defaultCategory})
  });
  // when the #segment/family/class field changes
  $("#unspsc_form > #family").change(function() {
    // make a POST call and replace the content
    var family = $('#unspsc_form > #family :selected').val();
    var defaultCategory=$('#default_class').val();
    if(family == "") family="0";
    jQuery.get('/products/update_category_select/' + family,{type:"class", divId:"unspsc_form", defaultCategory:defaultCategory})
  });
  // when the #segment/family/class field changes
  $("#unspsc_form > #class").change(function() {
    // make a POST call and replace the content
    var myClass = $('#unspsc_form > #class :selected').val();
    var defaultCategory=$('#default_commodity').val();
    if(myClass == "") family="0";
    jQuery.get('/products/update_category_select/' + myClass,{type:"commodity", divId:"unspsc_form", defaultCategory:defaultCategory})
  });
  $("#unspsc_form > #commodity").change(function() {
    // make a POST call and replace the content
    var commodity = $('#unspsc_form > #commodity :selected').val();
    $('#product_category_id').val(commodity);
  });
  
})



$(document).ready(function() {
  $("#new_review").submitWithAjax();
  $("#fancybox-close").click(function() {
	// do stuff
	parent.location.reload(true);
  });
})