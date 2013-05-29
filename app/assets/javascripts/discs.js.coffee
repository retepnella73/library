# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#selected_category_id").change ->
    mydata = $(this).data();
    if mydata.discid?
      myurl = "/discs/" + mydata.discid + "/edit"
    else
      myurl = "/discs/new" 
    $.ajax
      url: myurl
      data:
        category_id: $("#selected_category_id").val()
      dataType: "script"

jQuery ->
  $('#discs_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    iDisplayLength: 10
    bStateSave: true
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [2]
    ,
      bVisible: false
      aTargets: [0]
    ,  
      iDataSort: 1
      aTargets: [3]
    ,
      bVisible: false
      aTargets: [1]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#discs').data('source')

jQuery ->
  $('#discs_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bStateSave: true
    bJQueryUI: true
    iDisplayLength: 10
    aoColumnDefs: [
      iDataSort: 0
      aTargets: [2]
    ,
      bVisible: false
      aTargets: [0]
    ,  
      iDataSort: 1
      aTargets: [3]
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
    sAjaxSource: $('#labels').data('source')

# label/show & /disc_formats/show & /genres/show
jQuery ->
  $('#label_discs_table').dataTable
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
      iDataSort: 1
      aTargets: [3]
    ,
      bVisible: false
      aTargets: [1]
    ]
    oLanguage: 
      sProcessing: "<img src='/assets/loading.gif'>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#discs').data('source')

# label/show & /disc_formats/show & genres/show logged in     
jQuery ->
  $('#label_discs_edit_table').dataTable
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
      iDataSort: 1
      aTargets: [3]
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

# discs/show
jQuery ->
  $('#disc_tracks_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ,
      bVisible: false
      aTargets: [1]
    ,
      iDataSort: 0
      aTargets: [3]
    ]

# discs/show for various artists disc
jQuery ->
  $('#disc_tracks_artist_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ,
      bVisible: false
      aTargets: [1]
    ,
      iDataSort: 0
      aTargets: [3]
    ,
      iDataSort: 1
      aTargets: [4]
    ]

# discs/show logged in
jQuery ->
  $('#disc_tracks_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ,
      bVisible: false
      aTargets: [1]
    ,
      iDataSort: 0
      aTargets: [3]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [5]
    ]

# discs/show for various artists disc & logged in
jQuery ->
  $('#disc_tracks_artist_edit_table').dataTable
    sDom: "<'row'<'span5'l><'span2'r><'span5'f>>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bJQueryUI: true
    aoColumnDefs: [
      bVisible: false
      aTargets: [0]
    ,
      bVisible: false
      aTargets: [1]
    ,
      iDataSort: 0
      aTargets: [3]
    ,
      iDataSort: 1
      aTargets: [4]
    ,
      bSortable: false
      bSearchable: false
      aTargets: [6]
    ]

