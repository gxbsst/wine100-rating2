require 'refinerycms-core'

module Refinery
  autoload :TestPapersGenerator, 'generators/refinery/test_papers_generator'

  module TestPapers
    require 'refinery/test_papers/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
