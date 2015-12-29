require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class WordsCount < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          return count_from_body
          nil
        end

        private

        def count_from_body
          nodes_from_body.map{|a| a.text}.join(' ').encode('UTF-8', :invalid => :replace).split.reject { |w| w !~ /([a-zA-Z]+(_[a-zA-Z]+)*)/ }.count
        end

        def node_from_meta
          @node_from_meta ||= meta_xpath(key: :name)
        end

        def nodes_from_body
          candidates.select { |node| valid_paragraph?(node) }
        end

        def valid_paragraph?(node)
          true
        end

        def candidates
          document.css('p,td,h1,h2,h3,h4,h5,h6,span')
        end

        def modelize(node, text, i = 1)
          model_class.new(node, text, i)
        end

      end
    end
  end
end
