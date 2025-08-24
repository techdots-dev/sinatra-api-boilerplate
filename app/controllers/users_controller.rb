class UsersController < BaseController
  get "/users" do
    users = User.all
    users.to_json
  end

  post "/users" do
    data = JSON.parse(request.body.read)
    user = User.create(name: data["name"], email: data["email"])
    status 201
    user.to_json
  end
end
