Rails.application.routes.draw do
  root 'welcome#home'
  
  resources :users, except: [:index] do
    resources :posts, path: "beans", except: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
