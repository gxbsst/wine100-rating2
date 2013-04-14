Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :members do
    resources :members, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :members, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :members, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
