module Jekyll
  class TableEnd < Liquid::Tag
    def render(context)
      "\n </div>"
    end
  end
end

Liquid::Template.register_tag('tableend', Jekyll::TableEnd)