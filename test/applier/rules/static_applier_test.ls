require '../../test_setup'

applier           = require '../../../index'
RulesApplier      = applier.rules.StaticApplier
ApplyContext      = applier.ApplyContext

fixtures = require '../../fixtures'
User     = fixtures.user
Book     = fixtures.book

# API - see https://github.com/kristianmandrup/rules-repo
RuleRepo          = ->
  clean: ->
    # todo
  can: {}
  cannot: {}

expect = require 'chai' .expect

# Note: Use rule-repo.display! for debugging internals of RuleRepo instances after rule application

describe 'StaicApplier' ->
  var book
  var repo
  var applier

  rules = {}

  create-applier = (ctx, rules, debug = true) ->
    new RulesApplier ctx, rules, debug

  create-repo = (name = 'static repo', debug = false) ->
    new RuleRepo name, debug .clean!

  create-exec-ctx = (debug = true) ->
    new ApplyContext create-repo!, debug

  create-rule-applier = (rules) ->
    create-applier create-exec-ctx!, rules, true

  exec-rule-applier = (rules, action-request) ->
    create-rule-applier rules .apply-rules!

  before ->
    book          := new Book 'Far and away'

  # can create, edit and delete a Book
  describe 'manage paper' ->
    context 'applied default rule: manage Paper' ->
      before ->
        rules.manage-paper :=
          default: ->
            @ucan    'manage',   'Paper'

        applier  := exec-rule-applier rules.manage-paper
        repo     := applier.repo!

      specify 'should add create, edit and delete can-rules' ->
        repo.can-rules!.should.eql {
          manage: ['Paper']
          create: ['Paper']
          delete: ['Paper']
          update: [ 'Paper']
          edit:   ['Paper']
        }


    xdescribe 'apply-rules' ->
      describe 'static' ->
        var rule-repo, rule-applier, rules

        before ->
          rules :=
            edit: ->
              @ucan     'edit',   'Book'
              @ucannot  'write',  'Book'
            read: ->
              @ucan    'read',   'Project'
              @ucannot 'delete', 'Paper'
            default: ->
              @ucan    'read',   'Paper'

          # adds only the 'read' rules (see access-request.action)
          rule-applier := exec-rule-applier rules
          rule-repo    := rule-applier.repo!

        specify 'adds all static can rules' ->
          rule-repo.can-rules.should.be.eql {
            read: ['Paper']
          }

        specify 'adds all static cannot rules' ->
          rule-repo.cannot-rules.should.be.eql {
          }