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
  // when the #segment/family/class field changes
  $("#segment").change(function() {
    // make a POST call and replace the content
    var segment = $('select#segment :selected').val();
    if(segment == "") segment="0";
    jQuery.get('/products/update_segment_select/' + segment)
  });
  // when the #segment/family/class field changes
  $("#family").change(function() {
    // make a POST call and replace the content
    var family = $('select#family :selected').val();
    if(family == "") family="0";
    jQuery.get('/products/update_family_select/' + family)
  });
  // when the #segment/family/class field changes
  $("#myClass").change(function() {
    // make a POST call and replace the content
    var myClass = $('select#myClass :selected').val();
    if(myClass == "") family="0";
    jQuery.get('/products/update_class_select/' + myClass)
  });
  $("#commodity").change(function() {
    // make a POST call and replace the content
    var commodity = $('select#commodity :selected').val();
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