//
//  DeviceListViewController.swift
//  Photon-Tinker
//
//  Created by Ido on 4/16/15.
//  Copyright (c) 2015 spark. All rights reserved.
//

import UIKit
import QuartzCore


let deviceNamesArr : [String] = [ "aardvark", "bacon", "badger", "banjo", "bobcat", "boomer", "captain", "chicken", "cowboy", "cracker", "cranky", "crazy", "dentist", "doctor", "dozen", "easter", "ferret", "gerbil", "hacker", "hamster", "hindu", "hobo", "hoosier", "hunter", "jester", "jetpack", "kitty", "laser", "lawyer", "mighty", "monkey", "morphing", "mutant", "narwhal", "ninja", "normal", "penguin", "pirate", "pizza", "plumber", "power", "puppy", "ranger", "raptor", "robot", "scraper", "scrapple", "station", "tasty", "trochee", "turkey", "turtle", "vampire", "wombat", "zombie" ]
let kDefaultCoreFlashingTime : Int = 30
let kDefaultPhotonFlashingTime : Int = 15
let kDefaultElectronFlashingTime : Int = 15

class DeviceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SparkSetupMainControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(image: UIImage(named: "imgTrianglifyBackgroundBlue")!)
        backgroundImage.frame = UIScreen.mainScreen().bounds
        backgroundImage.contentMode = .ScaleToFill;
        
        if !SparkCloud.sharedInstance().isAuthenticated
        {
            self.logoutButton.setTitle("Log in", forState: .Normal)
        }
        //        backgroundImage.alpha = 0.85
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
        srandom(arc4random())
        
    }
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var devices : [SparkDevice] = []
    var deviceIDflashingDict : Dictionary<String,Int> = Dictionary()
    var deviceIDflashingTimer : NSTimer? = nil
    
    var selectedDevice : SparkDevice? = nil
    var lastTappedNonTinkerDevice : SparkDevice? = nil
    var refreshControlAdded : Bool = false
    
    //    var deviceIDsBeingFlashed : Dictionary<String, Int> = Dictionary()
    //    var flashingTimer : NSTimer? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    @IBOutlet weak var setFlashingTestButton: UIButton!
    //
    //    @IBAction func setFlashingButtonTapped(sender: AnyObject) {
    //        self.devices[0].isFlashing = true
    //        self.deviceIDflashingDict[self.devices[0].id] = kDefaultPhotonFlashingTime
    //
    //        self.photonSelectionTableView.reloadData()
    //
    //    }
    
    @IBOutlet weak var photonSelectionTableView: UITableView!
    
    @IBAction func setupNewDeviceButtonTapped(sender: UIButton) {
        
        // heading
        let optionMenu = UIAlertController(title: nil, message: "Setup New Device", preferredStyle: .ActionSheet)
        
        
        // 1
        let setupPhotonAction = UIAlertAction(title: "Photon", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.invokePhotonDeviceSetup()
        })
        
        // 2
        let setupElectronAction = UIAlertAction(title: "Electron/SIM", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if SparkCloud.sharedInstance().loggedInUsername != nil {
                self.invokeElectronSetup()
            } else {
                TSMessage.showNotificationWithTitle("Authentication", subtitle: "You must be logged to your Particle account in to setup an Electron ", type: .Error)
            }
        })
        
        // 3
        let setupCoreAction = UIAlertAction(title: "Core", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.showSparkCoreAppPopUp()
        })
        
        // cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        // 4
        optionMenu.addAction(setupPhotonAction)
        optionMenu.addAction(setupElectronAction)
        optionMenu.addAction(setupCoreAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    func invokeElectronSetup() {
        Mixpanel.sharedInstance().timeEvent("Tinker: Electron setup activity")
        let esVC : ElectronSetupViewController = self.storyboard!.instantiateViewControllerWithIdentifier("electronSetup") as! ElectronSetupViewController
        self.presentViewController(esVC, animated: true, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.deviceIDflashingTimer!.invalidate()
        self.lastTappedNonTinkerDevice = nil
        
        
        let deviceInfo = self.getDeviceTypeAndImage(self.selectedDevice)
        
        if segue.identifier == "tinker" {
            if let vc = segue.destinationViewController as? SPKTinkerViewController {
                vc.device = self.selectedDevice
                vc.deviceListViewController = self
                
                Mixpanel.sharedInstance().track("Tinker: Start Tinkering", properties: ["device":deviceInfo.deviceType, "running_tinker":vc.device.isRunningTinker()])
                
            }
        }
        
        if segue.identifier == "info" {
            if let vc = segue.destinationViewController as? DeviceInfoViewController {
                vc.device = self.selectedDevice
                vc.deviceListViewController = self
                
                Mixpanel.sharedInstance().track("Tinker: Info", properties: ["device":deviceInfo.deviceType])
                
            }
        }

    
    }


    var statusEventID : AnyObject?
    
    override func viewWillAppear(animated: Bool) {
        if SparkCloud.sharedInstance().isAuthenticated
        {
            self.loadDevices()
            print("! subscribing to status event")
            self.statusEventID = SparkCloud.sharedInstance().subscribeToMyDevicesEventsWithPrefix("spark/status", handler: { (event: SparkEvent?, error: NSError?) in
                // if we received a status event so probably one of the device came online or offline - update the device list
                self.loadDevices()
                print("! got status event: "+event!.description)
            })
            
            self.deviceIDflashingTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(DeviceListViewController.flashingTimerFunc(_:)), userInfo: nil, repeats: true)
        }
        Mixpanel.sharedInstance().timeEvent("Tinker: Device list screen activity")
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        SparkCloud.sharedInstance().unsubscribeFromEventWithID(self.statusEventID!)
        print("! unsubscribing from status event")
        Mixpanel.sharedInstance().track("Tinker: Device list screen activity")
    }
    
    
    func flashingTimerFunc(timer : NSTimer)
    {
        for (deviceid, timeleft) in self.deviceIDflashingDict
        {
            if timeleft > 0
            {
                self.deviceIDflashingDict[deviceid]=timeleft-1
            }
            else
            {
                self.deviceIDflashingDict.removeValueForKey(deviceid)
                //self.photonSelectionTableView.reloadData()
                self.loadDevices()
            }
        }
    }
    
    func loadDevices()
    {
        var hud : MBProgressHUD
        
        // do a HUD only for first time load
        if self.refreshControlAdded == false
        {
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = .CustomView//.Indeterminate
            hud.animationType = .ZoomIn
            hud.labelText = "Loading"
            hud.minShowTime = 0.4
            
            // prepare spinner view for first time populating of devices into table
            let spinnerView : UIImageView = UIImageView(image: UIImage(named: "imgSpinner"))
            spinnerView.frame = CGRectMake(0, 0, 37, 37);
            spinnerView.contentMode = .ScaleToFill
            let rotation = CABasicAnimation(keyPath:"transform.rotation")
            rotation.fromValue = 0
            rotation.toValue = 2*M_PI
            rotation.duration = 1.0;
            rotation.repeatCount = 1000; // Repeat
            spinnerView.layer.addAnimation(rotation,forKey:"Spin")
            
            hud.customView = spinnerView
            
        }
        
        
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            SparkCloud.sharedInstance().getDevices({ (devices:[AnyObject]?, error:NSError?) -> Void in
                
                self.handleGetDevicesResponse(devices, error: error)
                
                // do anyway:
                dispatch_async(dispatch_get_main_queue()) {
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    // first time add the custom pull to refresh control to the tableview
                    if self.refreshControlAdded == false
                    {
                        self.addRefreshControl()
                        self.refreshControlAdded = true
                    }
                }
            })
        }
    }
    
    
    
    func handleGetDevicesResponse(devices:[AnyObject]?, error:NSError?)
    {
        if let e = error
        {
            //            print("error listing devices for user \(SparkCloud.sharedInstance().loggedInUsername)")
            //            print(e.description)
            if e.code == 401 {
                //                print("invalid access token - logging out")
                self.logoutButtonTapped(self.logoutButton)
            } else {
                TSMessage.showNotificationWithTitle("Error", subtitle: "Error loading devices, please check your internet connection.", type: .Error)
            }
        }
        else
        {
            if let d = devices
            {
                self.devices = d as! [SparkDevice]
                
                // Sort alphabetically
                self.devices.sortInPlace({ (firstDevice:SparkDevice, secondDevice:SparkDevice) -> Bool in
                    if let n1 = firstDevice.name
                    {
                        if let n2 = secondDevice.name
                        {
                            return n1 < n2 //firstDevice.name < secondDevice.name
                        }
                    }
                    return false;
                    
                })
                
                // then sort by device type
                self.devices.sortInPlace({ (firstDevice:SparkDevice, secondDevice:SparkDevice) -> Bool in
                    return firstDevice.type.rawValue > secondDevice.type.rawValue
                })
                
                // and then by online/offline
                self.devices.sortInPlace({ (firstDevice:SparkDevice, secondDevice:SparkDevice) -> Bool in
                    return firstDevice.connected && !secondDevice.connected
                })
                
                // and then by running tinker or not
                self.devices.sortInPlace({ (firstDevice:SparkDevice, secondDevice:SparkDevice) -> Bool in
                    return firstDevice.isRunningTinker() && !secondDevice.isRunningTinker()
                })
                
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.photonSelectionTableView.reloadData()
            }
        }
    }
    
    func addRefreshControl()
    {
        
        //        let refreshFont = UIFont(name: "Gotham-Book", size: 17.0)
        
        self.photonSelectionTableView.addPullToRefreshWithPullText("Pull To Refresh", refreshingText: "Refreshing Devices") { () -> Void in
            //        self.photonSelectionTableView.addPullToRefreshWithPullText("Pull To Refresh", pullTextColor: UIColor.whiteColor(), pullTextFont: refreshFont, refreshingText: "Refreshing Devices", refreshingTextColor: UIColor.whiteColor(), refreshingTextFont: refreshFont) { () -> Void in
            SparkCloud.sharedInstance().getDevices() { (devices:[AnyObject]?, error:NSError?) -> Void in
                self.handleGetDevicesResponse(devices, error: error)
                self.photonSelectionTableView.finishLoading()
            }
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }
    
    
    
    func getDeviceTypeAndImage(device : SparkDevice?) -> (deviceType: String, deviceImage: UIImage) {
        
        var image : UIImage?
        var text : String?
        
        switch (device!.type)
        {
        case .Core:
            image = UIImage(named: "imgDeviceCore")
            text = "Core"
            
        case .Electron:
            image = UIImage(named: "imgDeviceElectron")
            text = "Electron"
            
        case .Photon:
            image = UIImage(named: "imgDevicePhoton")
            text = "Photon/P0"
            
        case .P1:
            image = UIImage(named: "imgDeviceP1")
            text = "P1"
            
        case .RedBearDuo:
            image = UIImage(named: "imgDeviceRedBearDuo")
            text = "RedBear Duo"
            
        case .Bluz:
            image = UIImage(named: "imgDeviceBluz")
            text = "Bluz"
            
        case .DigistumpOak:
            image = UIImage(named: "imgDeviceDigistumpOak")
            text = "Digistump Oak"
            
        default:
            image = UIImage(named: "imgDeviceUnknown")
            text = "Unknown"
            
        }
        
        
        return (text!, image!)
        
    }
    
    
    func getDeviceStateDescAndImage(device : SparkDevice?) -> (deviceStateText : String, deviceStateImage : UIImage) {
        let online = device?.connected
        var text : String?
        var image : UIImage?
        
        switch online!
        {
        case true :
            switch device!.isRunningTinker()
            {
            case true :
                text = "Online (Tinker)"
                image = UIImage(named: "imgGreenCircle") // TODO: breathing cyan
            default :
                text = "Online"
                image = UIImage(named: "imgYellowCircle") // TODO: breathing cyan
            }
            
            
        default :
            text = "Offline"
            image = UIImage(named: "imgRedCircle") // gray circle
            
        }
        
        return (text!,image!)
    
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var masterCell : UITableViewCell?
        
        if indexPath.row < self.devices.count
        {
            let cell:DeviceTableViewCell = self.photonSelectionTableView.dequeueReusableCellWithIdentifier("device_cell") as! DeviceTableViewCell
            if let name = self.devices[indexPath.row].name
            {
                cell.deviceNameLabel.text = name
            }
            else
            {
                cell.deviceNameLabel.text = "<no name>"
            }
            
            let deviceInfo = self.getDeviceTypeAndImage(self.devices[indexPath.row])

            cell.deviceImageView.image = deviceInfo.deviceImage
            cell.deviceTypeLabel.text = " "+deviceInfo.deviceType+" "
            cell.deviceTypeLabel.backgroundColor = UIColor(red: 0, green: 186.0/255.0, blue: 236.0/255.0, alpha: 0.72)
            
            cell.deviceTypeLabel.textColor = UIColor(white: 0.96, alpha: 1.0)
            cell.deviceTypeLabel.layer.cornerRadius = 4
            cell.deviceTypeLabel.layer.masksToBounds = true

//            cell.deviceIDLabel.text = ""//devices[indexPath.row].id.uppercaseString
            

            let deviceStateInfo = getDeviceStateDescAndImage(devices[indexPath.row])
            cell.deviceStateLabel.text = deviceStateInfo.deviceStateText
            cell.deviceStateImageView.image = deviceStateInfo.deviceStateImage

            // override everything else
            if devices[indexPath.row].isFlashing || self.deviceIDflashingDict.keys.contains(devices[indexPath.row].id)
            {
                cell.deviceStateLabel.text = "Flashing"
                cell.deviceStateImageView.image = UIImage(named: "imgPurpleCircle") // gray circle
            }
            
            
            masterCell = cell
        }
        
        // make cell darker if it's even
        if (indexPath.row % 2) == 0
        {
            masterCell?.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.25)
        }
        else // lighter if even
        {
            masterCell?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        }
        
        return masterCell!
    }
    
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // user swiped left
        if editingStyle == .Delete
        {
            TSMessage.showNotificationInViewController(self, title: "Unclaim confirmation", subtitle: "Are you sure you want to remove this device from your account?", image: UIImage(named: "imgQuestionWhite"), type: .Error, duration: -1, callback: { () -> Void in
                // callback for user dismiss by touching inside notification
                TSMessage.dismissActiveNotification()
                tableView.editing = false
                } , buttonTitle: " Yes ", buttonCallback: { () -> Void in
                    // callback for user tapping YES button - need to delete row and update table (TODO: actually unclaim device)
                    self.devices[indexPath.row].unclaim() { (error: NSError?) -> Void in
                        if let err = error
                        {
                            TSMessage.showNotificationWithTitle("Error", subtitle: err.localizedDescription, type: .Error)
                            self.photonSelectionTableView.reloadData()
                        }
                    }
                    
                    self.devices.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
                    // update table view display to show dark/light cells with delay so that delete animation can complete nicely
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                        tableView.reloadData()
                    }}, atPosition: .Top, canBeDismissedByUser: true)
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Unclaim"
    }
    
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        // user touches elsewhere
        TSMessage.dismissActiveNotification()
    }
    
    // prevent "Setup new photon" row from being edited/deleted
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row < self.devices.count
    }
    
    
    func sparkSetupViewController(controller: SparkSetupMainController!, didFinishWithResult result: SparkSetupMainControllerResult, device: SparkDevice!) {
        if result == .Success
        {
            Mixpanel.sharedInstance().track("Tinker: Device setup activity", properties: ["result":"success"])
            
            if let deviceAdded = device
            {
                if (deviceAdded.name == nil)
                {
                    let deviceName = self.generateDeviceName()
                    deviceAdded.rename(deviceName, completion: { (error:NSError?) -> Void in
                        if let _=error
                        {
                            TSMessage.showNotificationWithTitle("Device added", subtitle: "You successfully added a new device to your account but there was a problem communicating with it. Device has been named \(deviceName).", type: .Warning)
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue()) {
                                TSMessage.showNotificationWithTitle("Success", subtitle: "You successfully added a new device to your account. Device has been named \(deviceName).", type: .Success)
                                self.photonSelectionTableView.reloadData()
                            }
                        }
                    })
                    
                    
                }
                else
                {
                    TSMessage.showNotificationWithTitle("Success", subtitle: "You successfully added a new device to your account. Device is named \(deviceAdded.name).", type: .Success)
                    self.photonSelectionTableView.reloadData()
                    
                }
            }
            else // Device is nil so we treat it as not claimed
            {
                TSMessage.showNotificationWithTitle("Success", subtitle: "You successfully setup the device Wi-Fi credentials. Verify its LED is breathing cyan.", type: .Success)
                self.photonSelectionTableView.reloadData()
            }
        }
        else if result == .SuccessNotClaimed
        {
            TSMessage.showNotificationWithTitle("Success", subtitle: "You successfully setup the device Wi-Fi credentials. Verify its LED is breathing cyan.", type: .Success)
            self.photonSelectionTableView.reloadData()
        }
        else
        {
            Mixpanel.sharedInstance().track("Device setup process", properties: ["result":"cancelled or failed"])
            TSMessage.showNotificationWithTitle("Warning", subtitle: "Device setup did not complete.", type: .Warning)
        }
    }
    
    func invokePhotonDeviceSetup()
    {
//        let dsc = SparkSetupCustomization.sharedInstance()
//        dsc.brandImage = UIImage(named: "setup-device-header")
        
        if let vc = SparkSetupMainController(setupOnly: !SparkCloud.sharedInstance().isAuthenticated)
        {
            Mixpanel.sharedInstance().timeEvent("Tinker: Device setup activity")
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func showSparkCoreAppPopUp()
    {
        Mixpanel.sharedInstance().track("Tinker: User wants to setup a Core")
        
        let popup = Popup(title: "Core setup", subTitle: "Setting up a Core requires the legacy Spark Core app. Do you want to install/open it now?", cancelTitle: "No", successTitle: "Yes", cancelBlock: {()->() in }, successBlock: {()->() in
            let sparkCoreAppStoreLink = "itms://itunes.apple.com/us/app/apple-store/id760157884?mt=8";
            Mixpanel.sharedInstance().track("Tinker: Send user to old Spark Core app")
            UIApplication.sharedApplication().openURL(NSURL(string: sparkCoreAppStoreLink)!)
        })
        popup.incomingTransition = .SlideFromBottom
        popup.outgoingTransition = .FallWithGravity
        popup.backgroundBlurType = .Dark
        popup.roundedCorners = true
        popup.tapBackgroundToDismiss = true
        popup.backgroundColor = UIColor.clearColor()// UIColor(red: 0, green: 123.0/255.0, blue: 181.0/255.0, alpha: 1.0) //UIColor(patternImage: UIImage(named: "imgTrianglifyBackgroundBlue")!)
        popup.titleColor = UIColor.whiteColor()
        popup.subTitleColor = UIColor.whiteColor()
        popup.successBtnColor = UIColor(red: 0, green: 186.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        popup.successTitleColor = UIColor.whiteColor()
        popup.cancelBtnColor = UIColor.clearColor()
        popup.cancelTitleColor = UIColor.whiteColor()
        popup.borderColor = UIColor.clearColor()
        popup.showPopup()
        
    }
    
    /*
     // keep track of devices being flashed with [device_id : seconds_left_to_flashing] dictionary
     func flashingTimerFunc(timer : NSTimer)
     {
     if self.deviceIDsBeingFlashed.count > 0
     {
     println(self.deviceIDsBeingFlashed)
     for id in deviceIDsBeingFlashed.keys
     {
     self.deviceIDsBeingFlashed[id] = self.deviceIDsBeingFlashed[id]! - 1
     if self.deviceIDsBeingFlashed[id]! < 1
     {
     self.deviceIDsBeingFlashed.removeValueForKey(id)
     }
     }
     }
     else
     {
     self.flashingTimer?.invalidate()
     }
     }
     */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        TSMessage.dismissActiveNotification()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let device = self.devices[indexPath.row]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        //                println("Tapped on \(self.devices[indexPath.row].description)")
        if devices[indexPath.row].isFlashing || self.deviceIDflashingDict.keys.contains(devices[indexPath.row].id)
        {
            TSMessage.showNotificationWithTitle("Device is being flashed", subtitle: "Device is currently being flashed, please wait for the process to finish.", type: .Warning)
            
        } else if device.connected && device.isRunningTinker() {
            self.selectedDevice = self.devices[indexPath.row]
            self.performSegueWithIdentifier("tinker", sender: self)
        } else {
            self.selectedDevice = self.devices[indexPath.row]
            self.performSegueWithIdentifier("info", sender: self)
        }
    }
    
    


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }


    func logoutButtonTapped(sender: UIButton) {
        SparkCloud.sharedInstance().logout()
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }

    }
    
    
    func generateDeviceName() -> String
    {
        let name : String = deviceNamesArr[Int(arc4random_uniform(UInt32(deviceNamesArr.count)))] + "_" + deviceNamesArr[Int(arc4random_uniform(UInt32(deviceNamesArr.count)))]
        
        return name
    }

    
}
