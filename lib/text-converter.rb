class TextConverter

  def self.to_html(markdown)
    genie = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        :autolink => true,
                                        :space_after_headers => true)
    genie.render(markdown)
  end
end
