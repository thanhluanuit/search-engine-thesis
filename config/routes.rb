Rails.application.routes.draw do
  root "home#index"
  get "search" => 'home#search', as: :search_documents
end
