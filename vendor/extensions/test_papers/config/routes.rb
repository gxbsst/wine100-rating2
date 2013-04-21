Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :test_papers do
    resources :test_papers, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :test_papers, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :test_papers, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
