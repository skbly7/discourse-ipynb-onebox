#!/bin/env ruby
# encoding: utf-8
# name: ipynb onebox
# version: 0.1
# authors: skbly7

Onebox = Onebox
class Onebox::Engine::IpynbOnebox
    include Onebox::Engine

    matches_regexp(/^(https?:)?\/\/.*\.ipynb(\?.*)?$/i)
    always_https

    private

    def data
        result = { link: link, id: Random.rand(1000) }
        result
    end

    def to_html
        <<HTML
        <div id="iframe-content-{{id}}">
          <iframe src="https://render.githubusercontent.com/view/ipynb?url={{link}}" width="100%" height="100%" frameborder="0"></iframe>
        </div>
        <script type="text/javascript">
          function iframeLoaded() {
            var iFrameID = document.getElementById('iframe-content-{{id}}');
            if(iFrameID) {
              // here you can make the height, I delete it first, then I make it again
              iFrameID.height = "";
              iFrameID.height = iFrameID.contentWindow.document.body.scrollHeight + "px";
            }
          }
        </script>
HTML
    end
end
