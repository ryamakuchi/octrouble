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

      expect(octrouble).to have_received(:get_issues).with('rails/rails', 1)
    end

    context 'user/repo リポジトリが入力されている場合' do
      it 'user/repo リポジトリの Issues が出力される' do
        expect { octrouble.issues('user/repo') }.to output {
          '"title 1","body 1","html_url 1"\n"title 2","body 2","html_url 2"\n"title 3","body 3","html_url 3"'
        }.to_stdout

        expect(octrouble).to have_received(:get_issues).with('user/repo', 1)
      end
    end

    context '--page 引数が入力されている場合' do
      before do
        allow(octrouble).to receive(:options) { { page: 2 } }
      end

      it 'そのページの Issues が出力される' do
        expect { octrouble.issues }.to output {
          '"title 1","body 1","html_url 1"\n"title 2","body 2","html_url 2"\n"title 3","body 3","html_url 3"'
        }.to_stdout

        expect(octrouble).to have_received(:get_issues).with('rails/rails', 2)
      end
    end

    context 'Issues が 0件だった場合' do
      before do
        allow(octrouble).to receive(:get_issues).and_return([])
      end

      it 'Issue is not found. という結果が出力される' do
        expect { octrouble.issues }.to output { 'Issue is not found.' }.to_stdout
        expect(octrouble).to have_received(:get_issues)
      end
    end

    context '該当するリポジトリが存在しない場合' do
      before do
        allow(octrouble).to receive(:get_issues).and_raise(
          Octokit::NotFound,
          "Octokit::NotFound\n" \
          "GET https://api.github.com/repos/ryamakuchi/none/issues?page=1: 404 - Not Found // See: https://developer.github.com/v3/issues/#list-issues-for-a-repository"
        ).and_return(nil)
      end

      it 'Repository is not found. という結果が出力される' do
        expect { octrouble.issues('ryamakuchi/none') }.to output {
          "Octokit::NotFound\n" \
          "GET https://api.github.com/repos/ryamakuchi/none/issues?page=1: 404 - Not Found // See: https://developer.github.com/v3/issues/#list-issues-for-a-repository\n" \
          "Repository 'ryamakuchi/none' is not found."
        }.to_stdout
        expect(octrouble).to have_received(:get_issues).with('ryamakuchi/none', 1)
      end
    end
  end
end
