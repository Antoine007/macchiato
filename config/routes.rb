Rails.application.routes.draw do
  # get 'questionnaire/save'

  # get 'answers/create'

  scope '(:locale)', locale: /fr|nl/ do

    post "corporation",        to: "corporations#create", as: "corporations"
    get  "thank_you",          to: "home#thank_you"
    get  "corporation/:token", to: "corporations#show"
    post "corporation/:token", to: "users#create",        as: "new_corporation_user"
    get  "/answers/all",       to: "answers#all",         as: "all_answers"
    post "contact_form",       to: "home#contact_form"


    resource 'subscriber', only: :create

    # if adding edit and update to corpdon't use resources but use :token
    resources :corporations, only: [:new] do

      get   "finish",              to: "corporations#finish"

      get   "users/:token",        to: "users#show",   as: "user_show"
      get   "users/:token/edit",   to: "users#edit",   as: "user_edit"
      patch "users/:token/update", to: "users#update", as: "user_update"

      post  "users/:token/answers/create", to: "answers#create", as: "answer_create"
      get   "users/:token/answers/show",   to: "answers#show",   as: "answer_show"

      resources :users,      only: [ :new, :create ]

    end

    get 'home', to: "home#home"

    get '/fr', to: "home#index", locale: "fr"
    get '/nl', to: "home#index", locale: "nl"
    get '/',   to: "home#index", locale: "en", as: "en"

    root "home#index"

  end

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
