//
//  ListUniversitiesViewController.swift
//  verzity
//
//  Created by Jossue Betancourt on 26/06/18.
//  Copyright © 2018 Jossue Betancourt. All rights reserved.

import UIKit
import SwiftyJSON
import Kingfisher

class ListUniversitiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var webServiceController = WebServiceController()  //WebServiceController()
    var type: String = ""
    var items:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = String(type)
        setup_table()
        setup_search_bar()
        setup_ux()
        alterLayout()
        load_data()
    }


    func setup_table(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setup_search_bar(){
        searchBar.delegate = self
    }
    
    func alterLayout(){
        //tableView.tableHeaderView = UIView()
    }
    
    func setup_ux(){
        
        // Title
        if  type == "find_favorit" {
            self.title = "Favoritos"
        } else if type == "find_university" {
            self.title = "Universidades"
        }
        
        self.navigationItem.leftBarButtonItem?.title = ""
        showGifIndicator(view: self.view)
    }
    
    func load_data(name_university: String = ""){
        
        if  type == "find_favorit" {
            items = [
                [
                    "idUniversida" : 40,
                    "nbUniversidad" : "Dw Medios",
                    "pathLogo" : "Jossue",
                ],
            ]
          hiddenGifIndicator(view: self.view)
        } else if type == "find_university" {
            
            var array_parameter = ["": ""]
            if  name_university != "" {
                array_parameter = ["nombreUniversidad": name_university]
            }
            
            let parameter_json = JSON(array_parameter)
            let parameter_json_string = parameter_json.rawString()
            webServiceController.BusquedaUniversidades(parameters: parameter_json_string!, doneFunction: GetListGeneral)
        }
    }
    
    func GetListGeneral(status: Int, response: AnyObject){
        var json = JSON(response)
        if status == 1{
            items = json["Data"].arrayValue as NSArray
            tableView.reloadData()
        }
        hiddenGifIndicator(view: self.view)
        
    }
    
  
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        load_data(name_university: searchText)
    }
    
    
    //Table View. -------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        var item_university = JSON(items[indexPath.section])
        
        //Nombre
        cell.name.text  = item_university["nbUniversidad"].stringValue
        // Imagen
        var pathImage = item_university["pathLogo"].stringValue
        pathImage = pathImage.replacingOccurrences(of: "~", with: "")
        pathImage = pathImage.replacingOccurrences(of: "\\", with: "")
        let url =  "\(String(describing: Config.desRutaMultimedia))\(pathImage)"
        let URL = Foundation.URL(string: url)
        let image_default = UIImage(named: "default.png")
        cell.icon.kf.setImage(with: URL, placeholder: image_default)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let university = items[indexPath.section]
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailUniversityViewControllerID") as! DetailUniversityViewController
        let university_json = JSON(university)
        vc.idUniversidad = university_json["idUniversidad"].intValue
        self.show(vc, sender: nil)
    }
    


}
