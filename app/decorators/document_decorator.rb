class DocumentDecorator < Draper::Decorator
  delegate_all

  def get_title
    title || description
  end
end
