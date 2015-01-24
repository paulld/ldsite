Rails.application.routes.draw do
  
  devise_for :users

  root 'static_pages#index'
  
  get   '/liste/'                                   => 'users#index',         as: 'users_list'
  get   '/trombi/'                                  => 'users#index_trombi',  as: 'users_trombi'
  get   'edit'                                      => 'users#edit'
  patch 'edit'                                      => 'users#update'
  get   '/liste/:username'                          => 'users#show',          as: 'user_show'

end
