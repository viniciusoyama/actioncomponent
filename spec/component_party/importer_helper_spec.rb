require 'rails_helper'

describe ComponentParty::ImporterHelper do
  let(:subject) do
    sub = Class.new do
      include ComponentParty::ImporterHelper

      def component
        OpenStruct.new(
          path: 'component/path',
          lookup_context: ActionView::LookupContext.new(['lookup/folder'])
        )
      end

    end.new

    sub
  end

  describe '#import_component' do
    describe 'generated component method' do
      it "calls render component" do
        expect(subject).to receive(:render).with(hash_including(component: 'my_path_to_header/folder'))

        subject.import_component 'Header', path: 'my_path_to_header/folder'

        subject.Header()
      end

      it "passes the view model data" do
        expect(subject).to receive(:render).with(hash_including(view_model_data: { data: 2 }))

        subject.import_component 'Header', path: 'my_path_to_header/folder'

        subject.Header(data: 2)
      end

      pending "passes the current component path"

    end

    it 'raises if there is no path' do
      expect {
        subject.import_component 'Header'
      }.to raise_error('No path informed when importing component Header')
    end
  end


end
