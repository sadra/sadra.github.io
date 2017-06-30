module Jekyll
  class LTR < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
    end

    def render(context)
      output =  "<div class='div-ltr' markdown='1'> \n"
      return output;
    end

  end
end

Liquid::Template.register_tag('ltr', Jekyll::LTR)
