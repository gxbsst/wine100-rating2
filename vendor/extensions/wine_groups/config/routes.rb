Refinery::Core::Engine.routes.append do

  # Frontend routes
  #namespace :wine_groups do
  #  resources :wine_groups, :path => '', :only => [:index, :show]
  #end

  # Admin routes
  namespace :wine_groups, :path => '' do

    namespace :admin, :path => 'refinery' do

      resources :wine_groups do
        resources :wine_group_items, :except => :show do
          collection do
            post :update_positions

          end
        end

        collection do
          post :create_wine_group_items
          post :update_positions
        end
      end
    end
  end


  ## Frontend routes
  #namespace :wine_groups do
  #  resources :wine_group_items, :only => [:index, :show]
  #end

  ## Admin routes
  namespace :wine_groups, :path => '' do
    namespace :admin, :path => 'refinery/wine_groups' do
      resources :wine_group_items, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
