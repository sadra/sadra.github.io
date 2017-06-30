module Jekyll
  class EndLTR < Liquid::Tag
    def render(context)
      "\n </div>"
    end
  end
end

Liquid::Template.register_tag('endltr', Jekyll::EndLTR)