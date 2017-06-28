module Jekyll
  class Table < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      input_split = @input

      output =  "<div class='table-container "+input_split+"' markdown='1'> \n"

      return output;
    end

    def split_params(params)
      params.split(" | ")
    end
  end
end

Liquid::Template.register_tag('table', Jekyll::Table)
