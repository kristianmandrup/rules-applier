// Generated by LiveScript 1.2.0
(function(){
  var applier, RulesApplier, ApplyContext, fixtures, User, Book, RuleRepo, expect;
  require('../../test_setup');
  applier = require('../../../index');
  RulesApplier = applier.rules.RulesApplier;
  ApplyContext = applier.ApplyContext;
  fixtures = require('../../fixtures');
  User = fixtures.user;
  Book = fixtures.book;
  RuleRepo = function(){
    return {
      clean: function(){
        return this;
      },
      clear: function(){
        return this;
      },
      can: {},
      cannot: {}
    };
  };
  expect = require('chai').expect;
  describe('RulesApplier', function(){
    var book, repo, rulesApplier, rules, requests, ctx, obj, createRepo, createExecCtx, createRulesApplier, execRuleApplier;
    rules = {};
    requests = {};
    ctx = {};
    obj = {};
    createRepo = function(){
      return new RuleRepo('static repo').clear();
    };
    createRepo = function(name, debug){
      name == null && (name = 'dynamic repo');
      debug == null && (debug = false);
      return new RuleRepo(name, debug).clean();
    };
    createExecCtx = function(debug){
      debug == null && (debug = true);
      return new ApplyContext(createRepo(), debug);
    };
    createRulesApplier = function(rules, accessRequest, debug){
      debug == null && (debug = true);
      return new RulesApplier(createExecCtx(), rules, accessRequest, debug);
    };
    execRuleApplier = function(rules, actionRequest){
      return createRulesApplier(rules, actionRequest).applyRules();
    };
    beforeEach(function(){
      return book = new Book('Far and away');
    });
    rules.managePaper = {
      area: function(){
        return this.ucan('manage', 'Paper');
      },
      admin: {
        domain: function(){
          return this.ucan('manage', 'Paper');
        }
      }
    };
    requests.readBook = {
      action: 'read',
      subject: book
    };
    rulesApplier = createRulesApplier(rules.managePaper, requests.readBook);
    describe('repo', function(){
      return expect(typeof rulesApplier.repo).to.eql('object');
    });
    describe('apply(thing, ctx)', function(){
      var res;
      beforeEach(function(){
        return res = rulesApplier.apply(thing, ctx);
      });
      return specify('res is ??', function(){});
    });
    describe('rule-applier(thing, ctx)', function(){
      return expect(rulesApplier.ruleApplier(thing, ctx)).to.be.an.instanceOf(RuleApplier);
    });
    return describe('apply-all', function(){
      var res;
      beforeEach(function(){
        return res = rulesApplier.applyAll();
      });
      specify('res is ??', function(){
        return expect(res).to.eql('xxx');
      });
      return specify('repo has rules', function(){
        return expect(res.repo).to.eql({});
      });
    });
  });
}).call(this);
