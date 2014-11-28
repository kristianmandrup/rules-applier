// Generated by LiveScript 1.2.0
(function(){
  var rule, KeyRuleApplier, fixtures, User, Book, createApplier;
  require('../../../test_setup');
  rule = require('../../../../index');
  KeyRuleApplier = rule.apply.single.KeyRuleApplier;
  fixtures = require('../../../fixtures');
  User = fixtures.user;
  Book = fixtures.book;
  createApplier = function(rules, name, context, debug){
    debug == null && (debug = true);
    return new KeyRuleApplier(rules, name, context, debug);
  };
  describe('KeyRuleApplier', function(){
    var applier, ctx;
    context('invalid', function(){
      return specify('throws', function(){
        return expect(createApplier({}, void 8)).to['throw'];
      });
    });
    return context('valid', function(){
      before(function(){
        return ctx = {
          edit: function(){
            return this.ucan('read', 'book');
          }
        };
      });
      specify('ok', function(){
        return expect(createApplier(ctx, 'edit')).to.not['throw'];
      });
      return describe('rules', function(){
        beforeEach(function(){
          return applier = createApplier(ctx, 'edit');
        });
        return specify('are set', function(){
          return expect(applier.rules).to.eql(ctx);
        });
      });
    });
  });
}).call(this);
