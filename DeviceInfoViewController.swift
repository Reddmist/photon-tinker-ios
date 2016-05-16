//
//  DeviceInfoViewController.swift
//  Particle
//
//  Created by Ido Kleinman on 5/10/16.
//  Copyright © 2016 Particle. All rights reserved.
//

import Foundation

class DeviceInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var deviceIPAddressLabel: UILabel!
    @IBOutlet weak var deviceStateLabel: UILabel!
//    @IBOutlet weak var firmwareVersionLabel: UILabel!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var lastHeardLabel: UILabel!
    @IBOutlet weak var deviceTypeLabel: UILabel!
    @IBOutlet weak var deviceIDLabel: UILabel!
    
    @IBAction func copyDeviceID(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = self.device?.id
        TSMessage.showNotificationWithTitle("Copied", subtitle: "Device ID was copied to the clipboard", type: .Success)
    }
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var IMEITitleLabel: UILabel!
    @IBOutlet weak var IMEILabel: UILabel!
    @IBOutlet weak var deviceStateImageView: UIImageView!

    @IBOutlet weak var ICCIDTitleLabel: UILabel!
    @IBOutlet weak var ICCIDLabel: UILabel!
    
    @IBOutlet weak var deviceDataTableView: UITableView!
    
    @IBOutlet weak var deviceImageView: UIImageView!
    
    @IBOutlet weak var copyDeviceIccidButton: UIButton!
    @IBOutlet weak var dataUsageTitleLabel: UILabel!
    @IBOutlet weak var dataUsageLabel: UILabel!
    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    var deviceListViewController : DeviceListViewController?
    
    var device : SparkDevice?
    
    override func viewDidLoad() {
        let backgroundImage = UIImageView(image: UIImage(named: "imgTrianglifyBackgroundBlue")!)
        backgroundImage.frame = UIScreen.mainScreen().bounds
        backgroundImage.contentMode = .ScaleToFill;
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
        self.deviceDataTableView.delegate = self
        self.deviceDataTableView.dataSource = self

    }
    
    var variablesList : [String]?
    
    @IBAction func copyDeviceIccid(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = self.device?.lastIccid
        TSMessage.showNotificationWithTitle("Copied", subtitle: "Device SIM ICCID was copied to the clipboard", type: .Success)

    }
    
    @IBAction func refresh(sender: AnyObject) {
        self.device?.refresh({ (err: NSError?) in
            
            // test what happens when device goes offline and refresh is triggered
            if (err == nil) {
                self.updateDeviceInfoDisplay()
            }
        })
    }
    
    @IBAction func editDeviceName(sender: AnyObject) {
    }
    
    var signalling : Bool = false
    
    @IBAction func signalDevice(sender: AnyObject) {
        signalling = !signalling
        self.device?.signal(signalling, completion: nil)
        // TODO: change button when active/inactive
    }
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    
    private func updateDeviceInfoDisplay() {
        if self.device!.type != .Electron {
            self.ICCIDTitleLabel.hidden = true
            self.IMEITitleLabel.hidden = true
            self.IMEILabel.hidden = true
            self.ICCIDLabel.hidden = true
            self.dataUsageLabel.hidden = true
            self.dataUsageTitleLabel.hidden = true
            self.copyDeviceIccidButton.hidden = true
            
            // try to decrease size for auto layout table to expand up
            tableViewTopConstraint.constant = 8;
            
        } else {
            self.IMEILabel.text = self.device?.imei
            self.ICCIDLabel.text = self.device?.lastIccid
            tableViewTopConstraint.constant = 36;
            
        }
        
        self.deviceIPAddressLabel.text = self.device?.lastIPAdress
        self.lastHeardLabel.text = self.device?.lastHeard?.description.stringByReplacingOccurrencesOfString("+0000", withString: "") // process
        self.deviceNameLabel.text = self.device?.name
        self.deviceIDLabel.text = self.device?.id
        self.connectionLabel.text = (self.device!.type == .Electron) ? "Cellular" : "Wi-Fi"
        
        let deviceStateInfo = self.deviceListViewController!.getDeviceStateDescAndImage(self.device)
        self.deviceStateLabel.text = deviceStateInfo.deviceStateText
        self.deviceStateImageView.image = deviceStateInfo.deviceStateImage
        
        let deviceInfo = self.deviceListViewController!.getDeviceTypeAndImage(self.device)
        self.deviceImageView.image = deviceInfo.deviceImage
        self.deviceTypeLabel.text = deviceInfo.deviceType
        
        self.variablesList = [String]()
        for (key, value) in (self.device?.variables)! {
            self.variablesList?.append(String("\(key) (\(value))"))
        }
        
        self.dataUsageLabel.hidden = true
        self.device?.getCurrentDataUsage({ (dataUsed: Float, err: NSError?) in
            if let _ = err {
                self.dataUsageTitleLabel.hidden = true
            } else {
                self.dataUsageLabel.hidden = false
                let ud = NSString(format: "%.3f", dataUsed)
                self.dataUsageLabel.text = "\(ud) MBs"
            }
        })
        
        self.deviceDataTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        // move to refresh function
        
        self.updateDeviceInfoDisplay()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title : String?
        switch section {
        case 0 : title = "Functions"
        case 1 : title = "Variables"
        default : title = "Events"
        }
        return title
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return self.device!.functions.count
        case 1 : return self.device!.variables.count
        default : return 1;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        var masterCell : UITableViewCell?
        
        let cell : UITableViewCell? = self.deviceDataTableView.dequeueReusableCellWithIdentifier("infoCell")
        
        switch indexPath.section {
        case 0 : // Functions
            cell!.textLabel?.text = self.device?.functions[indexPath.row]
        case 1 :
            cell!.textLabel?.text = self.variablesList![indexPath.row]
        default :
            cell!.textLabel?.text = "Tap for events stream"
            
            
        }
        
        return cell!
        
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows where selectedIndexPaths.contains(indexPath) {
            return 100.0 // Expanded height
        }
        
        return 44.0 // Normal height
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        updateTableView()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        updateTableView()
    }
    
    private func updateTableView() {
        self.deviceDataTableView.beginUpdates()
        self.deviceDataTableView.endUpdates()
    }
    
    
//    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView!
//    {
//        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 30))
//        headerView.backgroundColor = UIColor.clearColor()

        
//        
//        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
//        tempLabel.backgroundColor=[UIColor clearColor];
//        tempLabel.shadowColor = [UIColor blackColor];
//        tempLabel.shadowOffset = CGSizeMake(0,2);
//        tempLabel.textColor = [UIColor redColor]; //here you can change the text color of header.
//        tempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSizeForHeaders];
//        tempLabel.font = [UIFont boldSystemFontOfSize:fontSizeForHeaders];
//        tempLabel.text=@"Header Text";
//        
//        [tempView addSubview:tempLabel];
//        
//        [tempLabel release];
//        return tempView;
        
//        
//        return headerView
//    }
//    
    
    
    
    
}