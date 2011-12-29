// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
jQuery(function($) {
  // when the #segment/family/class field changes
  $("#unspsc_search > #segment").ready(function() {
  	$("#unspsc_search > #segment").change();
  });
  
  $("#unspsc_search > #segment").change(function() {
    // make a POST call and replace the content
    var segment = $('select#segment :selected').val();
    var defaultCategory=$('#default_family').val();
    if(segment == "") segment="0";
    jQuery.get('/products/update_category_select/' + segment,{type:"family", divId:"unspsc_search", defaultCategory:defaultCategory})
  });
  // when the #segment/family/class field changes
  $("#unspsc_search > #family").change(function() {
    // make a POST call and replace the content
    var family = $('select#family :selected').val();
    var defaultCategory=$('#default_class').val();
    if(family == "") family="0";
    jQuery.get('/products/update_category_select/' + family,{type:"class", divId:"unspsc_search", defaultCategory:defaultCategory})
  });
  // when the #segment/family/class field changes
  $("#unspsc_search > #class").change(function() {
    // make a POST call and replace the content
    var myClass = $('select#class :selected').val();
     var defaultCategory=$('#default_commodity').val();
    if(myClass == "") family="0";
    jQuery.get('/products/update_category_select/' + myClass,{type:"commodity", divId:"unspsc_search", defaultCategory:defaultCategory})
  });
   $("#unspsc_search > #commodity").change(function() {
    // make a POST call and replace the content
    var commodity = $('select#commodity :selected').val();
    $('#search_category_id').val(commodity);
    $('#aExtendUnspscDescr').html("Select Category("+commodity+")");
  });
})

$(document).ready(function() {
  $("#extendUnspsc").click(function() {
    if (document.getElementById('unspsc_search').style.display=="none"){
    	document.getElementById('unspsc_search').style.display="block";
    	$('#aExtendUnspsc').html("- ");
    }
    else {
    	document.getElementById('unspsc_search').style.display="none";
    	$('#aExtendUnspsc').html("+ ");
    }
  });
  $("#extendUnspscDescr").click(function() {
    if (document.getElementById('unspsc_search').style.display=="none"){
    	document.getElementById('unspsc_search').style.display="block";
    	$('#aExtendUnspsc').html("- ");
    }
    else {
    	document.getElementById('unspsc_search').style.display="none";
    	$('#aExtendUnspsc').html("+ ");
    }
  });
})
