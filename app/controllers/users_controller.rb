class UsersController < Base
  get "/api/users" do
    users = User.all
    users.to_json
  end

  post "/api/users" do
    data = JSON.parse(request.body.read)
    user = User.create(name: data["name"], email: data["email"])
    status 201
    user.to_json
  end
end
