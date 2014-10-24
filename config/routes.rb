Rails.application.routes.draw do
  root 'homes#index'
  get 'logins/' => 'logins#index'
  get 'logins/destroy' => 'logins#destroy'
  post 'logins/' => 'logins#create'
  get 'usuarios/' => 'usuarios#new'
  get 'usuarios/:id' => 'usuarios#show'
  post 'usuarios/' => 'usuarios#create'
  patch 'usuarios/:id' => 'usuarios#update'
  get 'teste/:banco' => 'testes#gerar_boleto'
  get 'bancos/' => 'bancos#index'
  get 'bancos/suportados' => 'bancos#bancos-suportados'
  get 'bancos/new' => 'bancos#new'
  get 'bancos/:id' => 'bancos#show'
  patch 'bancos/:id' => 'bancos#update'
  delete 'bancos/:id' => 'bancos#destroy'
  post 'bancos/' => 'bancos#create'
  get 'senhas/:id' => 'senhas#index'
  post 'senhas/update' => 'senhas#update'
  post 'boletos/' => 'boletogerados#create'
  get 'boletos/' => 'boletogerados#getall'
  get 'boletos/:id' => 'boletogerados#get'
  get 'meuboleto/:id' => 'boletogerados#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
