class HomeController < ApplicationController
  def index;end

  def search
    @response = Document.elasticsearch({ query: params[:query], page: params[:page]})
  end
end
