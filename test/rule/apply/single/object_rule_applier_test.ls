require '../../../test_setup'

rule              = require '../../../../index'
ObjectRuleApplier = rule.apply.single.ObjectRuleApplier

fixtures = require '../../../fixtures'
User     = fixtures.user
Book     = fixtures.book

create-applier = (rules, name, context, debug = true) ->
  new ObjectRuleApplier rules, name, context, debug

describe 'ObjectRuleApplier' ->
  var applier, ctx, object

  context 'invalid' ->
    specify 'throws' ->
      expect create-applier {}, void .to.throw

  context 'valid' ->
    before ->
      ctx :=
        action:
          edit: ->
            @ucan 'read', 'book'

      object := {
        action: 'edit'
      }

    specify 'ok' ->
      expect create-applier ctx, object .to.not.throw

    describe 'rules' ->
      before-each ->
        applier := create-applier ctx, object

      specify 'are set' ->
        expect applier.rules .to.eql ctx
