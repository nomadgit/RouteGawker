RouteGawker::Application.routes.draw do

  root :to => 'promenades#index'
  resources :promenades

end
