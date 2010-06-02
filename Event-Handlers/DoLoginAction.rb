#
#  DoLoginAction.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 20/05/2010.
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

class DoLoginAction

  def initialize(usernameField, passwordField, rememberMeCheckBox)
    super()
    
    @usernameField, @passwordField = usernameField, passwordField
    @rememberMeCheckBox = rememberMeCheckBox
    
    return self
  end # initialize

# --------------------

  def actionPerformed(event)
    LOG.warn "Login Action actionPerformed"
    puts @usernameField.getText, @passwordField.getText
    
    Net::HTTP.start(BioCatalogueClient.HOST.to_s) { |http|
      req = Net::HTTP::Get.new('/login')
      req.basic_auth @usernameField.getText, @passwordField.getText
      response = http.request(req)
      print response.body
    }

    
  end # actionPerformed

end
