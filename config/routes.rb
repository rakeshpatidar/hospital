Rails.application.routes.draw do
  

  get 'api/patient'
  get 'api/disease'
  get 'api/addpatient'

  resources :diseasecodes

  #devise_for :doctors
  devise_for :doctors, controllers: { registrations: "doctors/registrations", sessions: "doctors/sessions"}
=begin
devise_for :doctors, :controllers => { :sessions => "api1/v1/sessions" }
devise_scope :doctor do
  namespace :api1 do
    namespace :v1 do
      resources :sessions, :only => [:create, :destroy]
    end
  end
end
=end

resources :doctors

  resources :patients

  get 'welcome/index'

  devise_for :hospitaladmins
  devise_for :admins
  resources :dashboards, only: [:index]
  resources :hospitaladmin


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

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
