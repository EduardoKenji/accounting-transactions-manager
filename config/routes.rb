Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  resources :transactions

  get '/debit-account/search', to: 'transactions#search_debit_account'
  get '/debit-account/balance', to: 'transactions#balance_by_debit_account'

  get '/credit-account/search', to: 'transactions#search_credit_account'
  get '/credit-account/balance', to: 'transactions#balance_by_credit_account'

  root 'transactions#index'
end
