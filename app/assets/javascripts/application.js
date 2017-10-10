// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/position
//= require jquery-ui/widgets/sortable
//= require popper
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .

var CustomFormSettingClass = function() {
  var trSelector              = '.tr-custom-input-forms'
  var tableSelector           = 'table.table-custom-inputs'
  var tableBlankValueSelector = 'table.table-blank-value'
  var actionLinkSelector      = 'a.edit-custom-inputs'
  var inputTypeSelector       = 'select[name="custom_input[][input_type]"]'
  var optionsBoxSelector      = '.options-box'

  var getBlankCustomInputTr = function() {
    return $(document).find(tableBlankValueSelector + ' ' + trSelector)
  }

  var getParentTr = function(instance) {
    return instance.parents(trSelector)
  }

  var addTr = function() {
    $(tableSelector + ' tbody').append(getBlankCustomInputTr().clone().show())
  }

  var removeTr = function(trElement) {
    trElement.remove()
    if ($(tableSelector + ' tbody tr').length == 0) addTr()
  }

  var updateOptionsBox = function(trElement) {
    var optionsBox = trElement.find(optionsBoxSelector)
    if (trElement.find(inputTypeSelector).val().match('(radio_buttons|select|check_boxes)$')) {
      optionsBox.show()
    } else {
      optionsBox.hide()
    }
  }

  return {
    initOnce: function() {
      $(document).on('click', actionLinkSelector, function(e) {
        e.preventDefault()
        var action = $(this).data().action
        // console.log(action)
        if      (action == 'delete') { removeTr(getParentTr($(this))) }
        else if (action == 'add')    { addTr() }
      })

      $(document).on('change', inputTypeSelector, function(e) {
        updateOptionsBox(getParentTr($(this)))
      })
    },
    initTable: function() {
      $(trSelector).each(function() { updateOptionsBox($(this)) })
        $(tableSelector).find('tbody').sortable()
    }
  }
}

var CustomFormSetting = CustomFormSettingClass()
CustomFormSetting.initOnce()
