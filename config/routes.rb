Bawstun::Application.routes.draw do

  namespace :admin do
    mount RailsAdmin::Engine => '/dashboard', :as => 'rails_admin'
  end

  root :to => "catalog#index"

  Blacklight.add_routes(self)
  HydraHead.add_routes(self)
  Hydra::BatchEdit.add_routes(self)

  devise_for :users
  mount Sufia::Engine => '/'
  
  # Metadata Templates routes (based partly on catalog routes)
  resources 'metadata_manager', :only=>:index do
    collection do
      get 'page/:page', :action => :index
      get 'activity', :action => :activity, :as => :dashboard_activity
      get 'facet/:id', :action => :facet, :as => :dashboard_facet
    end
  end
  
end
