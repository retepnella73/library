# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#publishers_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [1]
    ,
      bVisible: false
      aTargets: [0]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [2, 3]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bStateSave: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#publishers').data('source')

jQuery ->
  $('#publishers_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [1]
    ,
      bVisible: false
      aTargets: [0]
    ,
      bSortable: false
      aTargets: [2]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [3, 4]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bStateSave: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#publishers').data('source')

