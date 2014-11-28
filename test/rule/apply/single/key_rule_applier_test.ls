requires  = require '../../../../../requires'

requires.test 'test_setup'

expect = require 'chai' .expect

KeyRuleApplier = requires.rule 'apply' .single.KeyRuleApplier

create-applier = (rules, name, context, debug = true) ->
  new KeyRuleApplier rules, name, context, debug

describe 'KeyRuleApplier' ->
  var applier, ctx

  context 'invalid' ->
    specify 'throws' ->
      expect create-applier {}, void .to.throw

  context 'valid' ->
    before ->
      ctx :=
        edit: ->
          @ucan 'read', 'book'

    specify 'ok' ->
      expect create-applier ctx, 'edit' .to.not.throw

    describe 'rules' ->
      before-each ->
        applier := create-applier ctx, 'edit'

      specify 'are set' ->
        expect applier.rules .to.eql ctx


#  apply: ->
#    @apply-obj-rules! or @apply-named-rules!
#
#  apply-named-rules: ->
#    @debug 'apply named rules', @named-rules!
#    @call-function! or @no-function!
#
#  call-function: ->
#    if typeof! @named-rules! is 'Function'
#      @debug 'call rules in', @execution-context
#      named-rules.call @execution-context, @access-request
#    @
#
#  no-function: ->
#    @debug "rules key for #{name} should be a function that resolves one or more rules"
#    @
#
#  named-rules: ->
#    @_named-rules ||= @rules[@name]
#
#  apply-obj-rules: ->