module.exports = User

class User
  (user) ->
    @set user

  set: (user)->
    for key of user
      @[key] = user[key]
