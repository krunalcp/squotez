Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :api do
    namespace :v1 do
      get "horoscope", to: "horoscopes#horoscope", as: "horoscope"
      get "parser/horoscope", to: "horoscope_datas#parser_horoscope"
      post "user", to: "user_datas#create", as: "user"
      get "info",  to: "infos#info", as: "info"
    end
  end

  root to: "admin/dashboard#index"
end
