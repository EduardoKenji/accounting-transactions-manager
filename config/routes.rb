Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  resources :transactions

  get '/account/search', to: 'transactions#search_account'
  get '/account/balance', to: 'transactions#balance_by_account'

  root 'transactions#index'
end
