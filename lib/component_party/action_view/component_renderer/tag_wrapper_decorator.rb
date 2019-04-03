# Decorates the template renderer chosen to render
# the current view/template/file.
# It overrides the render method in order to wrap the rendered template
# in a tag with data attributes
class ComponentParty::ActionView::ComponentRenderer::TagWrapperDecorator < SimpleDelegator
  attr_reader :component_path

  def initialize(target, component_path)
    @component_path = component_path
    super(target)
  end

  def render(context, options = {}, &block)
    rendered = __getobj__.render(context, options, &block)
    rendered = apply_html_namespacing(rendered.to_s)
    ActionView::OutputBuffer.new(rendered)
  end

  def apply_html_namespacing(raw_html)
    component_id = component_path.to_s.gsub(%r{^/}, '').tr('/', '-')
    "<div class='component' data-component-path='#{component_id}'>" + raw_html + '</div>'.html_safe
  end
end
