#!/usr/bin/ruby -Ku
# -*- coding: UTF-8 -*-
=begin
   geopost.cgi

   Copyright 2009 Masahiro Kawato

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

require 'fileutils'
require 'erb'
require 'yaml'

CGI_FILE = 'geopost.cgi'
HTML_FILE = 'geopost.html'
CONFIG_FILE = 'config.yml'

def write_file(filename)
  erb = ERB.new(IO.read(filename + ".erb"))
  open(filename, 'w') {|fout|
    fout.print(erb.result(binding))
  }
end

@config = YAML.load_file(CONFIG_FILE)

write_file(CGI_FILE)
write_file(HTML_FILE)

FileUtils.install(CGI_FILE, @config['cgi_dir'], :mode => 0755, :verbose => true)
FileUtils.install(HTML_FILE, @config['html_dir'], :mode => 0644, :verbose => true)
