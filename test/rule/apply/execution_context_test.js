// Generated by LiveScript 1.2.0
(function(){
  var rule, ExecutionContext, fixtures, User, Book, RuleRepo, expect;
  require('../../test_setup');
  rule = require('../../../index');
  ExecutionContext = rule.apply.ExecutionContext;
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
  describe('ExecutionContext', function(){
    var book, ruleRepo, rules, createRepo;
    rules = {};
    createRepo = function(){
      return new RuleRepo('static repo').clear();
    };
    return describe('create ExecuteContext', function(){
      context('with no repo', function(){
        return specify('throws error', function(){
          return expect(function(){
            return new ExecutionContext;
          }).to['throw'];
        });
      });
      context('with a valid repo', function(){
        return specify('creates with the repo', function(){
          return expect(function(){
            return new ExecutionContext(createRepo());
          }).to.not['throw'];
        });
      });
      return context('ExecuteContext with valid repo', function(){
        var ctx;
        before(function(){
          return ctx = new ExecutionContext(createRepo());
        });
        describe('ucan', function(){
          return specify('registers new can rule in repo', function(){
            ctx.ucan('edit', 'Book');
            return ctx.repo.canRules.should.eql({
              edit: ['Book']
            });
          });
        });
        return describe('ucannot', function(){
          return specify('registers new cannot rule in repo', function(){
            ctx.ucannot('edit', 'Book');
            return ctx.repo.cannotRules.should.eql({
              edit: ['Book']
            });
          });
        });
      });
    });
  });
}).call(this);
