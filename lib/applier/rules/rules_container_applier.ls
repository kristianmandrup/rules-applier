apply = require '../apply'
util = require '../../util'

# RulesAccessor     = rule.RulesAccessor
# RepoGuard ?

camel-case        = util.string.camel-case
Debugger          = util.Debugger

StaticApplier     = apply.StaticApplier
DynamicApplier    = apply.DynamicApplier
ExecutionContext  = apply.ExecutionContext

# To be used for a RuleContainer which contains both static and dynamic rules, f.ex a Permit
module.exports = class ContainerRulesApplier implements Debugger
  (@ctx, @access-request, @debugging = true) ->
    @_validate!
    @applied-rules = false
    @debug 'ctx', @ctx
    @rules = @ctx.rules
    @debug 'rules', @rules
    @

  _validate: ->
    unless typeof! @ctx is 'Object'
      throw Error "Apply Context must be an Object, was: #{@cxt}"

    unless @ctx.repo
      throw Error "Apply Context missing a .repo to store the applied rules, was: #{@cxt}"

  clean: ->
    @applied-rules = false

  static-applier: ->
    new StaticApplier @execution-context!, @rules, @debugging

  dynamic-applier: ->
    new DynamicApplier @execution-context!, @rules, @access-request, @debugging

  execution-context: ->
    @_executer ||= new ExecutionContext @ctx.repo!, @debugging

  rule-applier: ->
    new @rules-applier.clazz @ctx, @access-request, @debugging

  # TODO: put in module
  validate-access-request: ->
    unless typeof! @access-request is 'Object'
      throw Error "Invalid access request: #{@access-request}, must be an Object"

  applier-for: (type) ->
    @["#{type}Applier"]!

  # always called (can be overridden for custom behavior)
  apply: (type = 'static', force) ->
    @["apply#{camel-case type}"] force

  apply-dynamic: ->
    @applier-for('dynamic').apply-rules!

  # @force - set to force re-application of static rules
  apply-static: (force) ->
    @debug 'forcing static apply' if force
    unless @applied-rules and not force
      @debug 'apply static rules'
      # dynamic
      @applier-for('static').apply-rules!
      @applied-static-rules = true
    else
      @debug 'static rules already applied before', @applied-static-rules

