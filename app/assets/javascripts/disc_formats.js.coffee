# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# disc_formats/index
jQuery ->
  $('#disc_formats_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bStateSave: true
    bJQueryUI: true
    aoColumnDefs: [
      bSortable: false
      bSearchable: false
      aTargets: [1]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#disc_formats').data('source')

jQuery ->
  $('#disc_formats_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bStateSave: true
    bJQueryUI: true
    aoColumnDefs: [
      bSortable: false
      bSearchable: false
      aTargets: [1, 2]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#disc_formats').data('source')

