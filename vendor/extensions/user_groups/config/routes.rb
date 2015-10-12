Refinery::Core::Engine.routes.append do

  # Frontend routes
#  namespace :user_groups do
#    resources :user_groups, :path => '', :only => [:index, :show]
#  end

  # Admin routes
  namespace :user_groups, :path => '' do
    
    namespace :admin, :path => 'refinery' do

      resources :user_groups do
        resources :items, :except => :show do
          collection do
            post :update_positions
          end
        end
        collection do
          post :update_positions
          post :create_items
        end
      end
    end
  end


  # Frontend routes
#  namespace :user_groups do
#    resources :items, :only => [:index, :show]
#  end

  # Admin routes
  namespace :user_groups, :path => '' do
    namespace :admin, :path => 'refinery/user_groups' do
      resources :items, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
