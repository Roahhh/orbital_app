Rails.application.routes.draw do

  get 'castletowns/wishing_wells/wish'

  get 'sessions/new'

  get 'users/new'

  get 'students/new'

  get 'fight' => 'fights#index'

  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users

  resources :quests

  resources :itemassignments

  resources :items
  
  resources :messages do
    resources :comments
  end

  resources :bugreports do
    resources :bugcomments
  end
  scope module: 'users' do
    resources :add_stats, :add_exps, :roll_lucks, :equip_equipments, :unequip_equipments, :change_jobs, :use_heal_items
  end

  scope module: 'maps' do
    resources :starts, :prairies, :groves, :savage_mts, :faerie_woods
  end

  scope module: 'castletowns' do
    resources :wishing_wells, :item_shops, :towns, :taverns, :eq_shops, :castles
  end

  scope module: 'quests' do
    resources :mark_complete_quests
  end

  resources :conversations do
    resources :convomessages
  end
end
