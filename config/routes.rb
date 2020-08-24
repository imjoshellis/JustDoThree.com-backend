Rails.application.routes.draw do
  get "/tasks/overdue/", to: "tasks#overdue"

  resources :blocks
  resources :tasks

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
