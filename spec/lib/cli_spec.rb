require 'octrouble/cli'

RSpec.describe Octrouble::Cli do
  describe '#issues' do
    before do
      get_issues_mock = [
        double(
          'issue 1',
          title: 'title 1',
          body: 'body 1',
          html_url: 'html_url 1'
        ),
        double(
          'issue 2',
          title: 'title 2',
          body: 'body 2',
          html_url: 'html_url 2'
        ),
        double(
          'issue 3',
          title: 'title 3',
          body: 'body 3',
          html_url: 'html_url 3'
        )
      ]

      allow(octrouble).to receive(:get_issues).and_return(get_issues_mock)
    end

    subject(:octrouble) { Octrouble::Cli.new }

    it 'rails/rails リポジトリ（1ページ目）の Issues が出力される' do
      expect { octrouble.issues }.to output {
        '"title 1","body 1","html_url 1"\n"title 2","body 2","html_url 2"\n"title 3","body 3","html_url 3"'
      }.to_stdout

      expect(octrouble).to have_received(:get_issues) do | repo, page |
        expect(repo).to eq('rails/rails')
        expect(page).to eq(1)
      end
    end

    context '--page 引数が入力されている場合' do
      it 'そのページの Issues が出力される'
    end

    context 'Issues が 0件だった場合' do
      it 'Issue is not found. という結果が出力される'
    end

    context '該当するリポジトリが存在しない場合' do
      it 'Repository is not found. という結果が出力される'
    end
  end
end
