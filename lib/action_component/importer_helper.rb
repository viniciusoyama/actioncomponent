module ActionComponent
  # Exposes component rendering methods to Rails views

  module ImporterHelper
    # Description of #import_action_component
    #
    # @param local_component_name [String] Local's component name (in the view scope)
    # @param opts [Hash] default: {} Options.
    # @example
    def import_action_component(local_component_name, opts = {})
      raise "No path informed when importing component #{local_component_name}" if opts[:path].blank?

      define_singleton_method(local_component_name) do
        create_component(opts[:path]).render
      end
    end

    def create_component(component_path)
      ActionComponent::Component.new(component_path)
    end
  end
end
