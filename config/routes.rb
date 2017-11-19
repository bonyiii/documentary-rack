DocumentaryApp.router.config do
  get "/people", to: "person#index"
  get "/cars", to: "car#index"
  get /.*/, to: "person#show"
end
