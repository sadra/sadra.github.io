module Jekyll
  class Youtube < Liquid::Tag
    def initialize(tag_name, params, tokens)
      super
      @input = params
    end

    def render(context)

      youtube_id = @input.strip!

      output =  "<a href='https://www.youtube.com/watch?v="+youtube_id+"'><div class='video-container'><style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='http://www.youtube.com/embed/"+youtube_id+"' frameborder='0' allowfullscreen></iframe></div></div><a/>"

      return output;
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::Youtube)
