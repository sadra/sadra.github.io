module Jekyll
  class Aparat < Liquid::Tag
    def initialize(tag_name, params, tokens)
      super
      @input = params
    end

    def render(context)

      aparat_id = @input.strip!

      output =  '<div class="video-container"><style>.h_iframe-aparat_embed_frame{position:relative;} .h_iframe-aparat_embed_frame .ratio {display:block;width:100%;height:auto;} .h_iframe-aparat_embed_frame iframe {position:absolute;top:0;left:0;width:100%; height:100%;}</style><div class="h_iframe-aparat_embed_frame"> <span style="display: block;padding-top: 57%"></span><iframe src="https://www.aparat.com/video/video/embed/videohash/'+aparat_id+'/vt/frame" allowFullScreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" ></iframe></div></div>'

      return output;
    end
  end
end

Liquid::Template.register_tag('aparat', Jekyll::Aparat)
