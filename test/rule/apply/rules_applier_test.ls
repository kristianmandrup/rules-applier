require '../../test_setup'

rule              = require '../../../index'
RulesApplier      = rule.apply.RulesApplier
ExecutionContext  = rule.apply.ExecutionContext

fixtures = require '../../fixtures'
User     = fixtures.user
Book     = fixtures.book

# API - see https://github.com/kristianmandrup/rules-repo
RuleRepo          = ->
  clean: ->
    @
  clear: ->
    @
    # todo
  can: {}
  cannot: {}

expect = require 'chai' .expect

describe 'RulesApplier' ->
  var book
  var repo
  var rules-applier

  rules   = {}
  requests = {}
  ctx = {}
  obj = {}

  create-repo = ->
    new RuleRepo('static repo').clear!

  create-repo = (name = 'dynamic repo', debug = false) ->
    new RuleRepo name, debug .clean!

  create-exec-ctx = (debug = true) ->
    new ExecutionContext create-repo!, debug

  create-rules-applier = (rules, access-request, debug = true) ->
    new RulesApplier create-exec-ctx!, rules, access-request, debug

  exec-rule-applier = (rules, action-request) ->
    create-rules-applier(rules, action-request).apply-rules!

  before-each ->
    book          := new Book 'Far and away'

  rules.manage-paper :=
    area: ->
      @ucan    'manage',   'Paper'

    admin:
      domain: ->
        @ucan    'manage',   'Paper'

  requests.read-book :=
    action: 'read'
    subject: book

  rules-applier := create-rules-applier rules.manage-paper, requests.read-book

  describe 'repo' ->
    expect(typeof rules-applier.repo).to.eql 'object'

  describe 'apply(thing, ctx)' ->
    var res

    before-each ->
      res := rules-applier.apply(thing, ctx)

    specify 'res is ??' ->

  describe 'rule-applier(thing, ctx)' ->
    expect(rules-applier.rule-applier thing, ctx).to.be.an.instance-of RuleApplier

  # should iterate through rules object recursively and execute any function found
  describe 'apply-all' ->
    var res

    before-each ->
      res := rules-applier.apply-all!

    specify 'res is ??' ->
      expect(res).to.eql 'xxx'

    specify 'repo has rules' ->
      expect(res.repo).to.eql {}
