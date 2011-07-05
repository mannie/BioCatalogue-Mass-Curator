package org.biocatalogue.mass_curator.ui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.LayoutManager;

import javax.swing.BorderFactory;
import javax.swing.JCheckBox;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListCellRenderer;
import javax.swing.ListModel;
import javax.swing.border.Border;
import javax.swing.event.ListDataListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

import models.interfaces.BioCatalogueClient;
import models.interfaces.resources.Service;

public class ServiceListPanel extends JPanel implements ListSelectionListener {

  /**
   * 
   */
  private static final long serialVersionUID = -1245266709375561831L;
  
  // --
  
  private final BioCatalogueClient _biocatalogueClient;
  
  private final JPanel _serviceDetailPanel;  
  private JList _servicesList;
  
  // --
  
  public ServiceListPanel(BioCatalogueClient client, JPanel serviceDetailPanel) {
    super();
    
    _biocatalogueClient = client;
    _serviceDetailPanel = serviceDetailPanel;
   
    initUI();
  }

  private void initUI() {
    this.setLayout(new BorderLayout());
    
    _servicesList = new JList(new ServiceListModel(_biocatalogueClient));
    _servicesList.addListSelectionListener(this);
    _servicesList.setCellRenderer(new ServiceCellRenderer());
    
    this.add(new JScrollPane(_servicesList));
  }

  // --

  public void valueChanged(ListSelectionEvent e) {
    _serviceDetailPanel.setVisible(false);
    _serviceDetailPanel.removeAll();
        
    // TODO fetch and display content
    Service selectedService = (Service) ((JList)e.getSource()).getSelectedValue();
    _serviceDetailPanel.add(new JLabel(selectedService.getName()));
    
    _serviceDetailPanel.repaint();
    _serviceDetailPanel.setVisible(true);
    
    System.out.println(selectedService);
  }
  
}

// --

class ServiceListModel implements ListModel {

  private final BioCatalogueClient _biocatalogueClient;
  private Service[] _data;

  // -- 
  
  public ServiceListModel(BioCatalogueClient client) {
    _biocatalogueClient = client;
    
    _data = _biocatalogueClient.getServices();
  }

  // --
  
  public void addListDataListener(ListDataListener arg0) {
    // TODO Auto-generated method stub
    
  }

  public Service getElementAt(int index) {
    return _data[index];
  }

  public int getSize() {
    return _data.length;
  }

  public void removeListDataListener(ListDataListener arg0) {
    // TODO Auto-generated method stub
    
  }
  
}

// --

class ServiceCellRenderer extends JPanel implements ListCellRenderer {
  
  /**
   * 
   */
  private static final long serialVersionUID = -7679862428244107689L;

  private static final LayoutManager _layoutManager = new BorderLayout();
  private static final Border _etchedBorder = BorderFactory.createEtchedBorder();

  private static ServiceListModel _model;

  // --
  
  public ServiceCellRenderer() {
    super();    
    initUI();
  }

  private void initUI() {
    setOpaque(true);

    this.setLayout(_layoutManager);
    this.setBorder(_etchedBorder);
  }

  // --

  public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
    if (_model == null) _model = (ServiceListModel) list.getModel();
    
    Service service = _model.getElementAt(index);
    
    // initialize UI
    this.removeAll();
    this.setBackground(isSelected ? Color.GRAY : Color.WHITE);

    // add label
    JLabel label = new JLabel(service.getName());
    this.add(label);
    
    // add checkbox
    JCheckBox checkBox = new JCheckBox(); // TODO add change listener
    this.add(checkBox, BorderLayout.WEST);
        
    return this;
  }
}
