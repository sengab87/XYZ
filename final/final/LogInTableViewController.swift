//
//  LogInTableViewController.swift
//  final
//
//  Created by Dina Maala on 5/18/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//
//////////////////// This is the logintableViewController////////////////////////
// The class LogInTableViewController follow the UITextFieldDelegate ////////////
// The footer cell and header cells are used to remove the grey bounds of table//
// The sign up button is a property //////
// Country and codes are arrays to add to be added to the cells /////////////////
/////////////////////////////////////////////////////////////////////////////////
import UIKit

class LogInTableViewController: UITableViewController,UITextFieldDelegate {
    
    
    
    /////////// hearder,footer cells and signUpbutton properties ///////////
    @IBOutlet weak var footerCell: UITableViewCell!
    @IBOutlet weak var headerCell: UITableViewCell!
    @IBOutlet weak var signUpbutton: UIButton!
    @IBOutlet weak var countryCell: UITableViewCell!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryNumber: UITextField!
    @IBOutlet weak var subConnection: UIView!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var connectionView: UIView!
    
    var reachability = Reachability()
    let tokenStatus = UserDefaults.standard.object(forKey: "token") as? Int
 
    
    /// codeField is country countryCode and countryName is the label in / ////
    /// in countrycell ////////////////////////////////////////////////////////
    
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
    let Codes = [ "93","355","213","1684","376","244","1264","672","1268","54","374","297","61","43","994","1242","973","880","1246","375","32","501","229",
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        doneButton.tintColor = UIColor(red: 52/255, green: 168/255, blue: 83/255, alpha: 1)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.doneClicked))
        cancelButton.tintColor = UIColor(red: 52/255, green: 168/255, blue: 83/255, alpha: 1)
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: #selector(self.doneClicked))
        
        toolBar.setItems([cancelButton, flexButton, doneButton], animated: false)
        codeField.inputAccessoryView = toolBar
        countryNumber.inputAccessoryView = toolBar
        
        //self.countryCell.isEditing = true
        
        //////////// This is is to hide the nav bar //////////////////////////////////
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        //////////////////////////////////////////////////////////////////////////////
        
        //self.tableView.backgroundColor = UIColor.red
        //////////////////////// This is to control the button intially//////////////
        signUpbutton.layer.cornerRadius = 5
        signUpbutton.clipsToBounds = true
        /////////////////////////////////////////////////////////////////////////////
        
        /////////////////This is to dismiss keyboard ////////////////////////////
        /////////////////////////////////////////////////////////////////////////
       

      
       
        
      
        
        
        
    }
    override func loadView() {
        super.loadView()
        
        //////////////////////// This is to hide the header cell/////////////////////////
        headerCell.layer.borderWidth = 2
        headerCell.layer.backgroundColor = UIColor.white.cgColor
        headerCell.layer.borderColor = UIColor.white.cgColor
        //////////////////////// This is to hide the footer cell/////////////////////////
        footerCell.layer.borderWidth = 2
        footerCell.layer.backgroundColor = UIColor.white.cgColor
        footerCell.layer.borderColor = UIColor.white.cgColor
        ////////////////////////////////////////////////////////////////////////////////
    }
    override func viewWillAppear(_ animated: Bool) {
        //// here we created user defaults country name and code are passed from //////
        // the countryTableViewController /////////////////////////////////////////////
        let countryName = UserDefaults.standard.object(forKey: "countryName")
        let countryCode = UserDefaults.standard.object(forKey: "countryCode")
        connectionView.frame = CGRect(x: 0, y: 0, width:connectionView.frame.width, height: 1)
        connectionView.isHidden = true
        ///////////////////////////////////////////////////////////////////////////////
        ///// if the countryName and code are set from the countryTableViewController //
        if (countryName != nil) && (countryCode != nil)
        {
            
            self.countryName.text = countryName as? String
            countryCell.textLabel?.text = "Country"
            codeField.text = countryCode as? String
        }
        ////////////////////////////////////////////////////////////////////////////////
        ////////////////////// remove grey when cell is selected ///////////////////////
        if (countryCell.isSelected)
        {
            countryCell.isSelected = false
            print("yes")
            
        }
        ////////////////////////////////////////////////////////////////////////////////
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    ////////////////////////// One Section and 4 cells /////////////////////////////////

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    ////////////////////////////////////////////////////////////////////////////////////
    //////////// if phonrNumberisChanged change button colors //////////////////////////
    @IBAction func phoneNumberChanged(_ sender: UITextField)
    {
        if(sender.text?.isEmpty)!
        {
            signUpbutton.alpha = 0.5
            signUpbutton.isEnabled = false
        }
        else
        {
            signUpbutton.alpha = 1.0
            signUpbutton.isEnabled = true
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////
    //////////// if countryCode is changed /////////////////////////////////////////////
    
    @IBAction func countryCodeChanged(_ sender: UITextField) {
        //////////////////////////// if code is emptry show show from list //////////////////////////////////////
        if (sender.text?.isEmpty)!
        {
            countryName.text = "Select from list"
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        ///// if not empty do a loop if count is 1 loop in countries with 1 if more loop with more codes //////
        if (sender.text?.count == 1)
        {
           
            
            outerLoop: for index in 0...countries.count-1
            {
                //print(index)
                innerLoop: if (sender.text) == Codes[index]
                {
                    
                    countryName.text? = countries[index]
                    break outerLoop
                }
                else
                {
                    countryName.text? = "Invalid Country Code"
                    
                }
                
            }
        }
        if (sender.text?.count == 2)
        {
            
            
            outerLoop: for index in 0...countries.count-1
            {
                //print(index)
                innerLoop: if (sender.text) == Codes[index]
                {
                    
                    countryName.text? = countries[index]
                    break outerLoop
                }
                else
                {
                    countryName.text? = "Invalid Country Code"
                    
                }
                
            }
        }
        if (sender.text?.count == 3)
        {
            
            
            outerLoop: for index in 0...countries.count-1
            {
                //print(index)
                innerLoop: if (sender.text) == Codes[index]
                {
                    
                    countryName.text? = countries[index]
                    break outerLoop
                }
                else
                {
                    countryName.text? = "Invalid Country Code"
                    
                }
                
            }
        }
        if (sender.text?.count == 4)
        {
            
            
            outerLoop: for index in 0...countries.count-1
            {
                //print(index)
                innerLoop: if (sender.text) == Codes[index]
                {
                    countryName.text? = countries[index]
                    break outerLoop
                }
                else
                {
                    countryName.text? = "Invalid Country Code"
                    
                }
                
            }
        }
        if ((sender.text?.count)! > 4)
        {
                countryName.text? = "Invalid Country Code"
            
        }
        
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////// sending data to server to get validated ////////////////////////////////////////////
    ////////////////// status 200 cant connect to database ////////////////////////////////////////////////////
    ////////////////////// status 300 connected to database and everything fine ///////////////////////////////
    /////////////////////////// catch means phone number is wrong /////////////////////////////////////////////
    ///////////////////////////// other error no internet connection //////////////////////////////////////////
    ////////////////////////////// we need to create timer to dismiss view ////////////////////////////////////
    
    
    @IBAction func signUpbuttonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(countryNumber.text, forKey: "phoneNumber")
        let url = URL(string:"http://ahmedsengab-com.stackstaging.com/ios/logIn/authentication.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = "codeField=\(codeField.text!)&countryNumber=\(countryNumber.text!)&countryName=\(countryName.text!)"
        request.httpBody=body.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if (error == nil)
            {
                DispatchQueue.main.async(execute: {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<AnyHashable,AnyObject>
                            guard let parseJson = json else{
                            print ("error parsing")
                            return
                               
                        }
                        print(parseJson)
                        let status = parseJson["status"] as? String
                        let token = parseJson["token"] as? Int
                        if (status != nil)
                        {
                            
                            
                            
                           if (status == "200")
                           {
                            self.connectionView.frame = CGRect(x: 0, y: 0, width:self.connectionView.frame.width, height: 21)
                            self.connectionView.isHidden = false
                            self.connectionLabel.text = "Our service currently unavailable"
                           }
                           if (status == "300")
                           {
                             if (token != nil)
                             {
                             
                                //UserDefaults.standard.set(token , forKey: "token")
                                self.performSegue(withIdentifier: "codeVerificationSegue", sender: self)
                               
                             }
                          }
                        }
                    }
                    catch
                    {
                        print(error)
                        self.connectionView.frame = CGRect(x: 0, y: 0, width:self.connectionView.frame.width, height: 21)
                        self.connectionView.isHidden = false
                        self.connectionLabel.text = "Check Phone number"

                    }
                    
                })
            }
                else
                {
                  
                }
            
            }.resume()
       
        self.connectionView.frame = CGRect(x: 0, y: 0, width:self.connectionView.frame.width, height: 21)
        self.connectionView.isHidden = false
        self.connectionLabel.text = "Sending Authorization Code"
    
    }
    @objc func dismissKeyboard()
    {
        self.tableView.endEditing(true)
    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
    }
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if (reachability.connection != .none) {
            
        }
        else
        {
            self.connectionView.frame = CGRect(x: 0, y: 0, width:self.connectionView.frame.width, height: 21)
            self.connectionView.isHidden = false
            self.connectionLabel.text = "Disconnected Check Internet Connection"
        }
    }
}
