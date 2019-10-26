require 'octrouble'
require 'thor'
require 'octokit'

module Octrouble
  class Cli < Thor
    desc 'issues user/repo --page 1', 'get Issues data from GitHub API'
    method_option :page, aliases: '-p'

    def issues(repo='rails/rails')
      page = options[:page] ? options[:page] : 1
      issues = get_issues(repo, page)

      return puts "Issue is not found." if issues == []
      return puts "Repository \'#{repo}\' is not found." if issues.nil?

      issues.each do | issue |
        puts "\"#{issue.title[0, 30]}\"," \
          "\"#{issue.body[0, 50]}\"," \
          "\"#{issue.html_url}\"\n"
      end
    end

    private

    def get_issues(repo, page)
      begin
        Octokit.list_issues(repo, page: page)
      rescue => e
        puts "#{e.class}\n#{e.message}"
        nil
      end
    end
  end
end
