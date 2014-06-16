Wine100::Application.routes.draw do

  resources :final_awards, :only => [:index, :create, :show] do
    collection do
      post :final_final_score
    end
  end

  resources :awards do
    collection do
      post :final_score
    end
  end

  get "challenges/create"

  root :to => 'challenges#index'

  resources :wine_groups do
    member do
      get :cancel
      get :complete
    end
    collection do
      get :progress
    end
  end

  resources :challenges
  #resources :test_papers
  #put 'challenges', :to => 'challenges#create'
  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  resources :sessions

  match "refinery/wine_groups/wine_group_items", :to => "refinery/wine_groups/admin/wine_group_items#index"
  match "refinery/user_groups/items", :to => "refinery/user_groups/admin/items#index"

  match "refinery/test_papers/:wine_id/export", :to => "refinery/test_papers/admin/test_papers#export", :as => :export
  match "refinery/test_papers/:group_id/export_for_group", :to => "refinery/test_papers/admin/test_papers#export_for_group", :as => :export_for_group
  match "refinery/test_papers/:wine_group_id/export_for_wine_group", :to => "refinery/test_papers/admin/test_papers#export_for_wine_group", :as => :export_for_wine_group
  match "refinery/test_papers/export_all", :to => "refinery/test_papers/admin/test_papers#export_all", :as => :export_all


  #match "refinery/user_groups/:user_group_id/items", :to => "refinery/user_groups/admin/items#index"

  #namespace :refinery do
  #  namespace :admin, :path => 'refinery/user_groups' do
  #    resources :user_groups do
  #      resources :items
  #    end
  #  end
  #end
  #match "refinery/user_groups/items", :to => "refinery/user_groups/admin/items#index"

  #post "refinery/wine_groups/wine_group_items", :to => "refinery/wine_groups/admin/wine_group_sub_items#create"


  mount Refinery::Core::Engine, :at => '/'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
