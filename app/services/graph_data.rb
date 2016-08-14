class GraphData
  def initialize(tweet)
    @tweet = tweet
  end

  def build
    return if can_not_add_document?

    document = Document.find_or_initialize_by(url: params[:url], description: params[:description])
    if document.persisted? || document.save
      user = User.find_or_create_by(user_name: params[:user_name])
      user.documents << document

      params[:hashtags].each do |name|
        annotation = Annotation.find_or_create_by(name: name)

        document.annotations << annotation
        user.annotations << annotation
      end
    end
  end

  private

  def can_not_add_document?
    @tweet.urls.blank? || @tweet.urls.count > 1
  end

  def params
    {
      url:         @tweet.urls.first.expanded_url,
      hashtags:    @tweet.hashtags.map(&:text),
      user_name:   @tweet.user.name,
      description: @tweet.text
    }
  end
end
