//
//  countryTableViewController.swift
//  final
//
//  Created by Dina Maala on 5/19/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////
// The listofCountries variables has the letters that will be dispalyed on the right of Countries //
// The numberOfCountries is the number of countries in each letter /////////////////////////////////
// The cumbumberOfCountries is the coummulative number of countries from the previous sections
// this is used to get the correct countries in the cells //////////////////////////////////////////
// The Countries is just the list of countries thats is displayed in the table /////////////////////
// The countryCodes is the list of codes for the countries in the table ////////////////////////////
// The viewGrey is a view added on top of table when search button is pressed masking the current table
// The searchedCountries is the countries that are searched in the search field ////////////////////
// The searchController is related to searchfield //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
import UIKit

class countryTableViewController: UITableViewController,UISearchBarDelegate,UISearchResultsUpdating,UISearchDisplayDelegate{
    
    //////// List of Countries /////
    let listOfCountries = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","Y","Z"]
    
    //// number of Countries in each letter ////
    let numberOfCountries = [15,18,22,6,8,7,15,4,8,3,5,9,22,15,1,12,1,4,22,13,8,4,1,1,2]
    /// cummulative number of Countries /////
    let cumnumberOfCountries = [0,15,33,55,61,69,76,91,95,103,106,111,120,142,157,158,170,171,175,179,192,200,204,205,206,208]
    
    //// Countries ///
    let countries = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Cocos Islands",
    "Colombia",
    "Comoros",
    "Congo - Kinshasa",
    "Congo - Brazzaville",
    "Cook Islands",
    "Costa Rica",
    "Cote D'Ivoire",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Dominican Republic",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Guiana",
    "French Polynesia",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Kuwait",
    "Kyrgyzstan",
    "Lao",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico ",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montserrat",
    "Morocco ",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "North Korea",
    "Northern Mariana Islands",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania ",
    "Russian Federation",
    "Rwanda",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Serbia",
    "Senegal",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks & Caicos Islands",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "U.S Virgin Islands",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Wallis and Futuna Islands",
    "Yemen",
    "Zambia",
    "Zimbabwe",
]
    ////// Country codes corresponding to countrynames ////
    let countryCodes = [ "93","355","213","1684","376","244","1264","672","1268","54","374","297","61","43","994","1242","973","880","1246","375","32","501","229",
        "1441",
        "591",
        "387",
        "267",
        "55",
        "673",
        "359",
        "226",
        "257",
        "855",
        "237",
        "1",
        "238",
        "1345",
        "236",
        "235",
        "56",
        "86",
        "53",
        "61",
        "57",
        "269",
        "243",
        "242",
        "682",
        "506",
        "225",
        "385",
        "53",
        "357",
        "420",
        "45",
        "253",
        "1767",
        "1809",
        "1829",
        "1849",
        "670",
        "593",
        "20",
        "503",
        "240",
        "291",
        "372",
        "251",
        "500",
        "298",
        "679",
        "358",
        "33",
        "594",
        "689",
        "241",
        "220",
        "995",
        "49",
        "233",
        "350",
        "30",
        "299",
        "1473",
        "590",
        "1671",
        "502",
        "224",
        "245",
        "592",
        "509",
        "504",
        "852",
        "36",
        "354",
        "91",
        "62",
        "98",
        "964",
        "353",
        "972",
        "39",
        "1876",
        "81",
        "962",
        "7",
        "254",
        "686",
        "850",
        "82",
        "965",
        "996",
        "856",
        "371",
        "961",
        "266",
        "231",
        "218",
        "423",
        "370",
        "352",
        "853",
        "389",
        "261",
        "265",
        "60",
        "960",
        "223",
        "356",
        "692",
        "596",
        "222",
        "230",
        "269",
        "52",
        "691",
        "373",
        "377",
        "976",
        "1664",
        "212",
        "258",
        "95",
        "264",
        "674",
        "977",
        "31",
        "599",
        "687",
        "64",
        "505",
        "227",
        "234",
        "683",
        "672",
        "1670",
        "47",
        "968",
        "92",
        "680",
        "970",
        "507",
        "675",
        "595",
        "51",
        "63",
        "48",
        "351",
        "1939",
        "1787",
        "974",
        "262",
        "40",
        "7",
        "250",
        "685",
        "378",
        "239",
        "966",
        "381",
        "221",
        "248",
        "232",
        "65",
        "421",
        "386",
        "677",
        "252",
        "27",
        "34",
        "94",
        "249",
        "597",
        "268",
        "46",
        "41",
        "963",
        "886",
        "992",
        "255",
        "66",
        "288",
        "690",
        "676",
        "1868",
        "216",
        "90",
        "993",
        "1649",
        "688",
        "256",
        "380",
        "971",
        "44",
        "1",
        "598",
        "998",
        "678",
        "418",
        "58",
        "84",
        "1284",
        "1340",
        "681",
        "967",
        "260",
        "263"]
    
    var viewgray = UIView()
    var searchedCountries:[String]   =  []
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationController?.viewControllers.count)
        ////// set the properties of the search bar ////////////////////
        //The search is not hidden ////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////
        self.tableView.sectionIndexColor = UIColor.black
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Countries"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        /////////////////////////////////////////////////////////////////////////
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////// number od sections ////////////////////////////
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        ///// if search bar controller is active and search text is not empty we should///
        // return one section otherwise we get section count from listOfCountries//////////
        // variables /////////////////////////////////////////////////////////////////////
         if ((searchController.isActive) && (searchController.searchBar.text != ""))
        {
            return 1
        }
        else
        {
            return listOfCountries.count
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    /////////////////////////////// number of rows in each section /////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///// if search bar controller is active and search text is not empty we should///
        // return the number of searched countries in the sections. //////////////////////
        // That is equal to the number of rows in that search section. If no search we////
        // we return the numberOfrows in the section based on numberOfCountries //////////
        //////////////////////////////////////////////////////////////////////////////////
        if ((searchController.isActive) && (searchController.searchBar.text != ""))
        {
            return self.searchedCountries.count
        }
        else
        {
            return(numberOfCountries[section])
            
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////////// Return the header letters ///////////////////////////////////////////
    /// here we return the headerletter if no search. If these is search not hidden nil is returned //
    //////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String?
    {
        if ((searchController.isActive) && (searchController.searchBar.text != ""))
        {
            return nil
        }
        else
        {
        return(listOfCountries[section])
        }
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////customize the cell////////////////////////////////////////////
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name = ""
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        name = countries[indexPath.row + cumnumberOfCountries[indexPath.section]]
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "+" + countryCodes[indexPath.row + cumnumberOfCountries[indexPath.section]]
      
        

         if ((searchController.isActive) && (searchController.searchBar.text != ""))
        {
            cell.textLabel?.text = self.searchedCountries[indexPath.row]
            return cell
            
        }
        
        return cell
        //// here the cells are customize the issue is that if we search a letter we need ////
        // to bring the total number of countries that are before that letter ////////////////
        //////////////////////////////////////////////////////////////////////////////////////
        
    }
    ////////// return section index tiles(letters on the right ///////////////
    override func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        return(listOfCountries)
    }
    //////////////////////////////////////////////////////////////////////////
    ////////////////// here we get search ///////////////////////////////////
    func updateSearchResults(for searchController: UISearchController)
    {
       
        guard let searchText = self.searchController.searchBar.text
        else{
                return
        }
        self.filterContentForSearch(searchString: searchText)
    }
    func filterContentForSearch(searchString:String)
    {
        searchedCountries = countries.filter(){nil != $0.range(of: searchString)}
        //print(searchedCountries);
        tableView.reloadData()
       
    }
    //////////////////////////////////////////////////////////////////////////////////

    /////////////////// if search bar is tapped add grey subview //////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.tableView.isUserInteractionEnabled = false
        let screenRect = UIScreen.main.bounds.height
        viewgray.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10000*screenRect)
        self.tableView.addSubview(viewgray)
        viewgray.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.isUserInteractionEnabled = true
        viewgray.removeFromSuperview()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty)
        {
            self.tableView.isUserInteractionEnabled = false
            let screenRect = UIScreen.main.bounds.height
            viewgray.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10000*screenRect)
            self.tableView.addSubview(viewgray)
            viewgray.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        else
        {
        self.tableView.isUserInteractionEnabled = true
        viewgray.removeFromSuperview()
        }
    }
   
    /////// here we use userDefauls to se country name and code to pass it to LogInViewController ////////
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath)
    {
        let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
        let numb = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
        if (name != nil && numb != nil)
        {
            UserDefaults.standard.set(name!, forKey: "countryName")
            UserDefaults.standard.set(numb!, forKey: "countryCode")
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
}


