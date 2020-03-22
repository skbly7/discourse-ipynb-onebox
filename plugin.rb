#!/bin/env ruby
# encoding: utf-8
# name: ipynb onebox
# version: 0.1
# authors: skbly7

class Onebox::Engine::IpynbOnebox
    include Onebox::Engine

    REGEX = /^(https?:)?\/\/.*\.ipynb(\?.*)?$/i
    matches_regexp REGEX
    always_https

    def to_html
        ipynb_render_service = ENV['ONEBOX_IPYNB_RENDERER_HOSTNAME']
        secret = ENV['ONEBOX_IPYNB_RENDERER_SECRET']
        auth_hash = Digest::MD5.hexdigest(secret + @url)
        url_to_fetch = "http://#{ipynb_render_service}/render/ipynb?url=#{@url}&hash=#{auth_hash}"

        @raw ||= Onebox::Helpers.fetch_html_doc(url_to_fetch)

        <<-HTML
        #{@raw}
        HTML
    end
end
