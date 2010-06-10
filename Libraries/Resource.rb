#
#  Resource.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 10/06/2010.
#  Copyright (c) 2010 University of Manchester, UK.

=begin
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

module Resource

  def self.pathTo(resourceName)
    File.expand_path(File.join(RESOURCES_DIR, resourceName))
  end # self.pathToLocalResource
  
  def self.iconWithResource(resourceName)
    ImageIcon.new(self.pathTo(resourceName))
  end # self.iconWithResource
  
  def self.iconFor(key)
    begin
      case key.downcase
        when 'right-arrow', 'forward-arrow'
          @@R_ARROW ||= self.iconWithResource("arrow_right.png").freeze
        when 'left-arrow', 'back-arrow'
          @@L_ARROW ||= self.iconWithResource("arrow_left.png").freeze
        when 'remote-resource', 'url', 'weblink'
          @@REMOTE ||= self.iconWithResource("remote_resource.png").freeze
        when 'refresh', 'reload'
          @@REFRESH ||= self.iconWithResource("arrow_refresh.png").freeze
        when 'busy', 'loading', 'spinner', 'working'
          @@BUSY ||= self.iconWithResource("spinner.gif").freeze
        when 'service'
          @@SERVICE ||= self.iconWithResource("service.png").freeze
        when 'search', 'scope'
          @@SEARCH ||= self.iconWithResource("search.png").freeze
        when 'excel', 'excel-file'
          @@EXCEL ||= self.iconWithResource("excel.gif").freeze
        when 'open-folder', 'folder'
          @@FOLDER ||= self.iconWithResource("open.gif").freeze
        when 'upload'
          @@UPLOAD ||= self.iconWithResource("northeast_blue_arrow.png").freeze
        else
          raise "Icon for key '#{key}' not found"
      end
    rescue exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.iconFor
  
  
end # module Resource
