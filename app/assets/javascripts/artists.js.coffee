# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#artists_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    iDisplayLength: 10
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [1]
    ,  
      bVisible: false
      aTargets: [0]
    ,
      bSearchable: false
      aTargets: [1]
    ,
      bSearchable: false
      bSortable: false
      aTargets: [2, 3]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#artists').data('source')

jQuery ->
  $('#artists_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    iDisplayLength: 10
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [1]
    ,  
      bVisible: false
      aTargets: [0]
    ,
      bSearchable: false
      aTargets: [1]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [2, 3, 4]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#artists').data('source')

# artists/show
jQuery ->
  $('#artist_discs_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bStateSave: true
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [2]
    ,
      bVisible: false
      aTargets: [0]
    ,  
      bVisible: false
      aTargets: [1]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#discs').data('source')

# artists/show logged in
jQuery ->
  $('#artist_discs_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bStateSave: true
    bJQueryUI: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [2]
    ,
      bVisible: false
      aTargets: [0]
    ,  
      bVisible: false
      aTargets: [1]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [5]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#discs').data('source')


