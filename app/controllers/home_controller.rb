class HomeController < ApplicationController
  def index;end

  def search
    @documents = Document.search(params[:query]).records.to_a
  end
end
