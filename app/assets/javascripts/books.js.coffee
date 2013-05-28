# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#book_general_details_toggle").click ->
    $("#book_general_details").toggle "5000"

$ ->
  $("#book_dimensions_toggle").click ->
    $("#book_dimensions").toggle "5000"

$ ->
  $("#book_extra_details_toggle").click ->
    $("#book_extra_details").toggle "5000"

jQuery ->
  $('#books_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [3]
    ,
      iDataSort: 1
      aTargets: [4]
    ,
      iDataSort: 2
      aTargets: [5]
    ,
      bVisible: false
      aTargets: [0, 1, 2]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#books').data('source')

jQuery ->
  $('#books_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [3]
    ,
      iDataSort: 1
      aTargets: [4]
    ,
      iDataSort: 2
      aTargets: [5]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [7]
    ,
      bVisible: false
      aTargets: [0, 1, 2]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#books').data('source')

