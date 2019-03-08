module Docs
  class Bash < UrlScraper
    self.type = 'bash'
    self.release = '4.4'
    self.base_url = 'https://www.gnu.org/software/bash/manual'
    self.root_path = '/html_node/index.html'
    self.links = {
      home: 'https://www.gnu.org/software/bash/',
      code: 'http://git.savannah.gnu.org/cgit/bash.git'
    }

    html_filters.push 'bash/entries', 'bash/clean_html'

    options[:only_patterns] = [/\/html_node\//]

    options[:attribution] = <<-HTML
      Copyright &copy; 2000, 2001, 2002, 2007, 2008 Free Software Foundation, Inc.<br>
      Licensed under the GNU Free Documentation License.
    HTML

    def get_latest_version(&block)
      fetch('https://www.gnu.org/software/bash/manual/html_node/index.html') do |body|
        version = body.scan(/, Version ([0-9.]+)/)[0][0]
        block.call version[0...-1]
      end
    end
  end
end
