Rails.application.routes.draw do
  root to: 'home#index'
  get '/:lookup_code', to: 'links#show', as: 'link'
  post '/links' => 'links#create'
end
