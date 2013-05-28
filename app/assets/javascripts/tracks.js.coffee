# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#tracks_table').dataTable
     sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
     sPaginationType: "bootstrap"
     bJQueryUI: true
     iDisplayLength: 25
     bStateSave: true

jQuery ->
  $('#tracks_table_edit').dataTable
     sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
     sPaginationType: "bootstrap"
     bJQueryUI: true
     iDisplayLength: 25
     aoColumnDefs: [
       bSortable: false
       bSearchable: false
       aTargets: [2]
     ]
     bStateSave: true

