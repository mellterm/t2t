T2t::Application.routes.draw do
  root :to => 'pages#welcome'
  
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"
  
  resources :users
  resources :assignments
  
  resources :repos do 
    resources :translations
  end
  
  resources :sessions

  get "assignments/new"

  match '/collaborate',  :to => 'assignments#new'
  
  
  match '/repos', :to => 'repo#index'
  match '/repo/:id/translations', :to => 'translation#index'
  resources :source_docs
  
  #makes urls look like this: www.example.com/en/users non locale display optional
  # scope "(:locale)", :locale => /en|de|ru|zh|es/ do
   
   # will take an optional format
   match "/cv(.:format)" => "pages#cv", :as => :cv

 #home
  root :to => 'pages#welcome'
  
  # match is a generic route use as to be able to access it via path or url
  match '/development', :to => 'pages#development'
  match '/contact', :to => 'pages#contact'
  match '/translate', :to => 'pages#translate'    
  get "pages/welcome"
  get "pages/development"
  get "pages/contact"
  get "pages/report"
  get "pages/dataimport"
  get "pages/log"
  get "pages/translate"
  get "pages/itranslate"
  get "pages/iwatchutranslate"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
