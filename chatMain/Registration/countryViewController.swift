//
//  countryViewController.swift
//  xmppTut
//
//  Created by Ahmed Sengab on 8/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class countryViewController: phoneNumberViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchResultsUpdating {
   
    

    ///////////// mainTableView is whole tableView ////////////
    ////// Intials is number of countries in each letter ///////
    ///intialsCumm is the total number of countries from previous letter ////
    /// letter is the intials of each country ///////
    /// searchController is the search bar //////////
    /// searched countries is seacherd countries in search bar /////
    /// layerView is grey mask that locks the view ////////////////
    
    @IBOutlet weak var mainTableView: UITableView!
    let intials = [15,21,22,7,9,8,15,4,9,3,5,9,23,16,1,12,1,4,22,14,8,3,2,1,3]
    let intialsCumm = [0 ,15, 36, 58, 65, 74, 82, 97, 101, 110, 113, 118, 127, 150, 166, 167, 179, 181, 184, 206, 220, 228, 231, 233, 234, 237]
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","Y","Z"]
    let searchController = UISearchController(searchResultsController: nil)
    var searchedCountries:[String]   =  []
    var searchedCodes:[String] = []
    var layerView = UIView()
    /////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //////// create searchbar function /////////////
    func createSearchBar()
    {
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Countries"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = UIColor.init(red: red, green:  green, blue: blue, alpha: 1)
        searchController.searchBar.tintColor = UIColor.init(red: red, green:  green, blue: blue, alpha: 1)
        
    }
    ///////////////////////////////////////////////////////
    //////////////// Table Delegate methods ///////////////
    ////// This method returns the number of sections in a table /////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let state = searchBarStatus()
        if (state == 1)
        {
            return searchedCountries.count
        }
        else{
            return(intials[section])
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////// This function returns cell ////////////////////////////////////////
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name = ""
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        name = countryNames[indexPath.row + intialsCumm[indexPath.section]]
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = codes[indexPath.row + intialsCumm[indexPath.section]]
        let state = searchBarStatus()
        if (state == 1)
        {
            cell.textLabel?.text = self.searchedCountries[indexPath.row]
            cell.detailTextLabel?.text = self.searchedCodes[indexPath.row]
        }
        return cell
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //// This function returns number of sections /////////
    func numberOfSections(in tableView: UITableView) -> Int {
        let state = searchBarStatus()
        if (state == 1)
        {
            return 1
        }
        else
        {
            return(letters.count)
        }
    }
    ///////////////////////////////////////////////////////
    // This function returns the title for each section A,B .. etc////
    func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        tableView.sectionIndexColor = UIColor.black
        return(letters)
    }
    /////////////////////////////////////////////////////////////////
    //////////////////////////// This function returns cell ///////////////////////////////////////////
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath)
    {
        let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
        var numb = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
        numb?.removeFirst()
        
        if (name != nil && numb != nil)
        {
            UserDefaults.standard.set(name, forKey: "countryName")
            UserDefaults.standard.set(numb, forKey: "countryCode")
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////// This function return title header in section //////////////////////////
    func tableView(_ tableView: UITableView,titleForHeaderInSection section: Int) -> String?{
        let state = searchBarStatus()
        if (state == 1)
        {
            return nil
        }
        else
        {
            return(letters[section])
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////
    
    ////////////////// Search bar results /////////////////////////////
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = self.searchController.searchBar.text
            else
        {
            return
        }
        filterContentForSearch(searchString: searchText)
    }
    ////////////////////////////////////////////////////////////////////
    /////////results of seached letters /////////////////
    func filterContentForSearch(searchString:String)
    {
        searchedCountries = countryNames.filter({$0.range(of: searchString) != nil})
        if searchedCountries.count != 0
        {
            modifyCodes(newCodes: searchedCountries)
        }
        mainTableView.reloadData()
    }
    /////////////////////////////////////////////////////
    
    ////////// get status of the search bar //////
    func searchBarStatus() ->Int
    {
        if (searchController.isActive) && (searchController.searchBar.text  != "")
        {
            return 1
        }
        else
        {
            return 0
        }
    }
    /////////////////////////////////////////////////
    //////////////// search bar started editing ////////////////////
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        showGreyView()
        return true
    }
    //////////////////////////////////////////////////////////////////
    //////////////////////// cancel button pressed  ////////////
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideGreyView()
    }
    //////////////////////////////////////////////////////////////////
    /////////// text in search bar is changed //////////////////////////////////
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty)
        {
            showGreyView()
        }
        else
        {
            hideGreyView()
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////// Hide and add layer View ///////////////////////////////////////////////
    func showGreyView()
    {
        mainTableView.isUserInteractionEnabled = false
        layerView.frame = CGRect(x: 0, y: 0, width:mainScreenWidth , height:10000*mainScreenWidth)
        mainTableView.addSubview(layerView)
        layerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    func hideGreyView()
    {
        mainTableView.isUserInteractionEnabled = true
        layerView.removeFromSuperview()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// This Function Modify the code //////////////////////////////////////
    func modifyCodes(newCodes:[String])
    {
        searchedCodes = []
        for p in 0...newCodes.count-1
        {
            for q in 0...countryNames.count-1
            {
                if newCodes[p] == countryNames[q]
                {
                    searchedCodes.append(codes[q])
                }
            }
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////
}
