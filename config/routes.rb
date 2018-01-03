Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :achievements, only: %i[new create show]
end
