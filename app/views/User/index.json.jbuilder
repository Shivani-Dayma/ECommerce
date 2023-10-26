# app/views/CONTROLLER_NAME/index.json.jbuilder

# json.array!(@users) do |user|
#     json.id user.id
#     json.name user.name
#     json.email user.email
#     json.password user.password
#     json.role user.role
#     json.address user.address
#   end
  json.array!(@users) do |user|
    json.id user.id
    json.name user.name
    json.email user.email
    json.role user.role
    json.address user.address
  end
  