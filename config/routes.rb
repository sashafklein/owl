Owl::Application.routes.draw do
  post :quotes, to: 'quotes#create'
end
