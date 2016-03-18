# Command line interface
module ReadmeReport
  require 'readme_report/report'
  require 'readme_report/version'
  
  class << self
    def cli
      puts "#{PRODUCT} #{VERSION}"

      if ARGV.count == 0
        usage
        exit
      end

      cli_repo = ARGV[0]

      unless cli_repo.include? '/'
        usage
        exit
      end

      repo = cli_repo.sub 'https://github.com/', ''

      correct repo
    end

    def usage
      puts "Usage: #{PRODUCT} <GitHub Repo>"
    end
  end
end
