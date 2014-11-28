util        = require '../../../util'
Debugger    = util.Debugger
ApplyMixin  = require './apply_mixin'

module.exports = class KeyRuleApplier implements ApplyMixin, Debugger
  (@rules, @key, @context, @debugging) ->
    @rules = @context-rules context
    @debug 'rules:', @rules, 'key:', @key, 'context:', @context, 'rules:', @rules
    @

  _type: 'KeyRuleApplier'

  apply: ->
    @apply-obj-rules! or @apply-named-rules!

  apply-named-rules: ->
    @debug 'apply named rules', @named-rules!
    @call-function! or @no-function!

  call-function: ->
    if typeof! @named-rules! is 'Function'
      @debug 'call rules in', @execution-context
      named-rules.call @execution-context, @access-request
    @

  no-function: ->
    @debug "rules key for #{@key} should be a function that resolves one or more rules"
    @

  named-rules: ->
    @_named-rules ||= @rules[@key]

  apply-obj-rules: ->
    object = @key
    @apply-obj-rules-for object, context if typeof! @key is 'Object'

