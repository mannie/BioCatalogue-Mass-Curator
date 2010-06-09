#
#  CheckBoxListener.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 24/05/2010.
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

class CheckBoxListener
  java_implements ChangeListener
  
  def initialize(service)
    super()
    @service = service
    return self
  end # initialize

# --------------------

  def stateChanged(event)
    if !event.getSource.getParent.showDetail && event.getSource.isSelected
      Cache.deselectServiceForAnnotation(@service)
      Cache.updateServiceListings
    elsif event.getSource.isSelected
      Cache.selectServiceForAnnotation(@service)
    else
      Cache.deselectServiceForAnnotation(@service)
    end
    
    SELECTED_SERVICES_WINDOW.refreshSelectedServices
    visible = SELECTED_SERVICES_WINDOW.isVisible
    SELECTED_SERVICES_WINDOW.setVisible(true) unless visible
    
    return if GenerateSpreadsheetAction.isBusyExporting

    Component.browsingStatusPanel.exportButton.setEnabled(
        !Cache.selectedServices.empty?)
    Component.browsingStatusPanel.refresh
  end # stateChanged
  
end
