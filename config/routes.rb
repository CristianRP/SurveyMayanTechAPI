Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :answers, controller: "answers", except: [:new, :edit]
    end
  end
end
