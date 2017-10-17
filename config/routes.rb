BrainRackApplication.router.config do
  get "/test", to: "custom#index"
  get "/cars", to: "car#index"
  get /.*/, to: "custom#show"
end
