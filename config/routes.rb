DocumentaryApp.router.config do
  get "/test", to: "person#index"
  get "/cars", to: "car#index"
  get /.*/, to: "person#show"
end
