//
// Created by Raimundas Sakalauskas on 04/09/2018.
// Copyright © 2018 Particle. All rights reserved.
//

import Foundation
import UIKit

class MeshSetupFlowUIManager : UIViewController, Storyboardable, MeshSetupFlowManagerDelegate {



    @IBOutlet weak var accountLabel: MeshLabel!

    private var flowManager: MeshSetupFlowManager!
    private var embededNavigationController: UINavigationController!

    private var targetDeviceType: ParticleDeviceType?
    private var targetDeviceDataMatrixString: String!
    private var targetDeviceName:String?

    private var commissionerDeviceType: ParticleDeviceType?
    private var commissionerDeviceDataMatrixString: String!


    private var selectedNetwork: MeshSetupNetworkInfo?
    private var didSelectNetwork: Bool = false
    private var selectedNetworkPassword: String?

    private var createNetworkName:String?
    private var createNetworkPassword:String?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.flowManager = MeshSetupFlowManager(delegate: self)
        self.flowManager.startSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.accountLabel.setStyle(font: MeshSetupStyle.RegularFont, size: MeshSetupStyle.SmallSize, color: MeshSetupStyle.PlaceHolderTextColor)
        self.accountLabel.text = ParticleCloud.sharedInstance().loggedInUsername ?? ""

        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        UIApplication.shared.isIdleTimerDisabled = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embedNavigation") {
            self.embededNavigationController = segue.destination as! UINavigationController

            let selectDeviceVC = self.embededNavigationController.viewControllers.first! as! MeshSetupSelectDeviceViewController
            selectDeviceVC.setup(didSelectDevice: targetDeviceSelected)
        }
        super.prepare(for: segue, sender: sender)
    }


    private func log(_ message: String) {
        if (MeshSetup.LogUIManager) {
            NSLog("MeshSetupFlowUI: \(message)")
        }
    }

    //MARK: Get Target Device Info
    func meshSetupDidRequestTargetDeviceInfo() {
        //do nothing here
    }


    func targetDeviceSelected(type: ParticleDeviceType) {
        log("target device type selected: \(type)")
        self.targetDeviceType = type

        DispatchQueue.main.async {
            let getReadyVC = MeshSetupGetReadyViewController.loadedViewController()
            getReadyVC.setup(didPressReady: self.showTargetDeviceGetReady, deviceType: self.targetDeviceType)
            self.embededNavigationController.pushViewController(getReadyVC, animated: true)
        }
    }

    func showTargetDeviceGetReady() {
        log("target device ready")

        DispatchQueue.main.async {
            let findStickerVC = MeshSetupFindStickerViewController.loadedViewController()
            findStickerVC.setup(didPressScan: self.showTargetDeviceScanSticker, deviceType: self.targetDeviceType)
            self.embededNavigationController.pushViewController(findStickerVC, animated: true)
        }
    }

    func showTargetDeviceScanSticker() {
        log("sticker found by user")

        DispatchQueue.main.async {
            let scanVC = MeshSetupScanStickerViewController.loadedViewController()
            scanVC.setup(didFindStickerCode: self.showTargetDevicePairing, deviceType: self.targetDeviceType)
            self.embededNavigationController.pushViewController(scanVC, animated: true)
        }
    }

    //user successfully scanned target code
    func showTargetDevicePairing(dataMatrixString: String) {
        log("dataMatrix scanned: \(dataMatrixString)")
        self.targetDeviceDataMatrixString = dataMatrixString

        //make sure the scanned device is of the same type as user requested in the first screen
        if let matrix = MeshSetupDataMatrix(dataMatrixString: self.targetDeviceDataMatrixString),
           let type = ParticleDeviceType(serialNumber: matrix.serialNumber),
           self.targetDeviceType == nil || type == self.targetDeviceType {
            self.targetDeviceType = type

            if let error = flowManager.setTargetDeviceInfo(dataMatrix: matrix) {
                NSLog("error = \(error)")
                //TODO: show error
                restartCaptureSession()
            } else {
                self.flowManager.pauseSetup()

                let pairingVC = MeshSetupPairingProcessViewController.loadedViewController()
                pairingVC.setup(didFinishScreen: targetDevicePairingScreenDone, deviceType: self.targetDeviceType, deviceName: flowManager.targetDeviceBluetoothName() ?? self.targetDeviceType!.description)
                self.embededNavigationController.pushViewController(pairingVC, animated: true)
            }
        } else {
            restartCaptureSession()
        }
    }

    func targetDevicePairingScreenDone() {
        self.flowManager.continueSetup()
    }

    func meshSetupDidRequestToUpdateFirmware() {
        DispatchQueue.main.async {
            let scanVC = MeshSetupFirmwareUpdateViewController.loadedViewController()
            scanVC.setup(didPressContinue: self.didSelectToUpdateFirmware)
            self.embededNavigationController.pushViewController(scanVC, animated: true)
        }
    }

    func didSelectToUpdateFirmware() {
        DispatchQueue.main.async {
            let updateFirmwareVC = MeshSetupFirmwareUpdateProgressViewController.loadedViewController()
            updateFirmwareVC.setup(didFinishScreen: self.targetDeviceFirmwareUpdateScreenDone)
            self.embededNavigationController.pushViewController(updateFirmwareVC, animated: true)
        }

        self.flowManager.setTargetPerformFirmwareUpdate(update: true)
    }

    func targetDeviceFirmwareUpdateScreenDone() {
        self.flowManager.continueSetup()
    }



    //TODO: For spectra we simply leave the current network. No hard feelings
    func meshSetupDidRequestToLeaveNetwork(network: Particle.MeshSetupNetworkInfo) {
        flowManager.setTargetDeviceLeaveNetwork(leave: true)
    }




    //the next thing to happen will be one out of 3:
    // 2)meshSetupDidEnterState: TargetDeviceScanningForNetworks
    // 3)meshSetupDidEnterState: TargetDeviceConnectingToInternet
    // 4)meshSetupDidEnterState: JoiningNetworkStarted //when adding additional devices









    //MARK: Scan networks
    private func showScanNetworks() {
        DispatchQueue.main.async {
            if let _ = self.embededNavigationController.topViewController as? MeshSetupSelectNetworkViewController {
                //do nothing
            } else {
                let networksVC = MeshSetupSelectNetworkViewController.loadedViewController()
                networksVC.setup(didSelectNetwork: self.didSelectNetwork)
                self.embededNavigationController.pushViewController(networksVC, animated: true)
            }
        }
    }


    func didSelectNetwork(network: MeshSetupNetworkInfo) {
        self.didSelectNetwork = true
        self.selectedNetwork = network

        flowManager.setSelectedNetwork(selectedNetwork: selectedNetwork!)
    }


    func meshSetupDidRequestToSelectNetwork(availableNetworks: [Particle.MeshSetupNetworkInfo]) {
        NSLog("scan complete")

        //if by the time this returned, user has already selected the network, ignore the results of last scan
        if let vc = self.embededNavigationController.topViewController as? MeshSetupSelectNetworkViewController {
            vc.setNetworks(networks: availableNetworks)

            //if no networks found = force instant rescan
            if (availableNetworks.count == 0) {
                rescanNetworks()
            } else {
                //rescan in 3seconds
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
                    [weak self] in
                    //only rescan if user hasn't made choice by now
                    self?.rescanNetworks()
                }
            }
        }
    }

    private func rescanNetworks() {
        if self.didSelectNetwork == false {
            if let vc = self.embededNavigationController.topViewController as? MeshSetupSelectNetworkViewController {
                if (flowManager.rescanNetworks() == nil) {
                    vc.startScanning()
                } else {
                    NSLog("rescanNetworks was attempted when it shouldn't be")
                }
            } else if let vc = self.embededNavigationController.topViewController as? MeshSetupSelectOrCreateNetworkViewController {
                if (flowManager.rescanNetworks() == nil) {
                    vc.startScanning()
                } else {
                    NSLog("rescanNetworks was attempted when it shouldn't be")
                }
            }
        }
    }


    //MARK: Connect to selected network
    func meshSetupDidRequestCommissionerDeviceInfo() {
        NSLog("requesting commisioner info!!")

        DispatchQueue.main.async {
            let getReadyVC = MeshSetupGetCommissionerReadyViewController.loadedViewController()
            getReadyVC.setup(didPressReady: self.showCommissionerDeviceFindSticker, deviceType: self.targetDeviceType, networkName: self.selectedNetwork!.name)
            self.embededNavigationController.pushViewController(getReadyVC, animated: true)
        }
    }

    func showCommissionerDeviceFindSticker() {
        log("commissioner device ready")

        let findStickerVC = MeshSetupFindCommissionerStickerViewController.loadedViewController()
        findStickerVC.setup(didPressScan: showCommissionerDeviceScanSticker, deviceType: self.targetDeviceType, networkName: self.selectedNetwork!.name)
        self.embededNavigationController.pushViewController(findStickerVC, animated: true)
    }

    func showCommissionerDeviceScanSticker() {
        log("sticker found by user")

        let scanVC = MeshSetupScanCommissionerStickerViewController.loadedViewController()
        scanVC.setup(didFindStickerCode: showCommissionerDevicePairing)
        self.embededNavigationController.pushViewController(scanVC, animated: true)
    }

    //user successfully scanned target code
    func showCommissionerDevicePairing(dataMatrixString: String) {
        log("dataMatrix scanned: \(dataMatrixString)")
        self.commissionerDeviceDataMatrixString = dataMatrixString

        //make sure the scanned device is of the same type as user requested in the first screen
        if let matrix = MeshSetupDataMatrix(dataMatrixString: self.commissionerDeviceDataMatrixString),
            let deviceType = ParticleDeviceType(serialNumber: matrix.serialNumber) {

            self.commissionerDeviceType = deviceType
            if let error = flowManager.setCommissionerDeviceInfo(dataMatrix: matrix) {
                NSLog("error = \(error)")
                //TODO: show error
                restartCaptureSession()
            } else {
                self.flowManager.pauseSetup()

                let pairingVC = MeshSetupPairingCommissionerProcessViewController.loadedViewController()
                pairingVC.setup(didFinishScreen: commissionerDevicePairingScreenDone, deviceType: deviceType, deviceName: flowManager.commissionerDeviceBluetoothName() ?? deviceType.description)
                self.embededNavigationController.pushViewController(pairingVC, animated: true)
            }
        } else {
            restartCaptureSession()
        }
    }


    private func restartCaptureSession() {
        if let vc = self.embededNavigationController.topViewController as? MeshSetupScanCommissionerStickerViewController {
            vc.startCaptureSession()
        } else if let vc = self.embededNavigationController.topViewController as? MeshSetupScanStickerViewController {
            vc.startCaptureSession()
        } else {
            NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupScanCommissionerStickerViewController / MeshSetupScanStickerViewController.restartCaptureSession was attempted when it shouldn't be")
        }
    }

    func commissionerDevicePairingScreenDone() {
        self.flowManager.continueSetup()
    }

    func meshSetupDidRequestToEnterSelectedNetworkPassword() {
        DispatchQueue.main.async {
            let passwordVC = MeshSetupNetworkPasswordViewController.loadedViewController()
            passwordVC.setup(didEnterPassword: self.didEnterNetworkPassword, networkName: self.selectedNetwork!.name)
            self.embededNavigationController.pushViewController(passwordVC, animated: true)
        }
    }

    func didEnterNetworkPassword(password: String) {
        self.selectedNetworkPassword = password
        flowManager.setSelectedNetworkPassword(password) { error in
            if error == nil {
                //this will happen automatically
            } else if let vc = self.embededNavigationController.topViewController as? MeshSetupNetworkPasswordViewController {
                self.selectedNetworkPassword = nil
                vc.setWrongInput(message: error!.description)
            }
        }
    }

    private func showJoiningNetwork() {
        DispatchQueue.main.async {
            let joiningVC = MeshSetupJoiningNetworkViewController.loadedViewController()
            joiningVC.setup(didFinishScreen: self.didFinishJoinNetworkScreen, networkName: self.selectedNetwork!.name, deviceType: self.targetDeviceType)
            self.embededNavigationController.pushViewController(joiningVC, animated: true)
        }
    }

    func didFinishJoinNetworkScreen() {
        self.flowManager.continueSetup()
    }

    func meshSetupDidRequestToEnterDeviceName() {
        DispatchQueue.main.async {
            let nameVC = MeshSetupNameDeviceViewController.loadedViewController()
            nameVC.setup(didEnterName: self.didEnterName, deviceType: self.targetDeviceType, currentName: self.flowManager.targetDeviceCloudName())
            self.embededNavigationController.pushViewController(nameVC, animated: true)
        }
    }

    func didEnterName(name: String) {
        self.targetDeviceName = name
        flowManager.setDeviceName(name: name) { error in
            if error == nil {
                //this will happen automatically
            } else if let vc = self.embededNavigationController.topViewController as? MeshSetupNameDeviceViewController {
                vc.setWrongInput(message: error!.description)
            }
        }
    }



    func meshSetupDidRequestToAddOneMoreDevice() {
        DispatchQueue.main.async {
            if (self.createNetworkName != nil && self.createNetworkPassword != nil) {
                self.createNetworkName = nil
                self.createNetworkPassword = nil
                //this is the end of create network flow
                let successVC = MeshSetupNetworkCreatedViewController.loadedViewController()
                successVC.setup(didSelectDone: self.didSelectSetupDone, deviceName: self.targetDeviceName!)
                self.embededNavigationController.pushViewController(successVC, animated: true)
            } else {
                //this is the end of joiner flow
                let successVC = MeshSetupSuccessViewController.loadedViewController()
                successVC.setup(didSelectDone: self.didSelectSetupDone, deviceName: self.targetDeviceName!)
                self.embededNavigationController.pushViewController(successVC, animated: true)
            }
        }
    }



    func didSelectSetupDone(done: Bool) {
        flowManager.setAddOneMoreDevice(addOneMoreDevice: !done)

        if (done) {
            //setup done
            self.dismiss(animated: true)
        } else {
            targetDeviceType = nil
            targetDeviceDataMatrixString = nil
            targetDeviceName = nil

            let getReadyVC = MeshSetupGetReadyViewController.loadedViewController()
            getReadyVC.setup(didPressReady: showTargetDeviceGetReady, deviceType: self.targetDeviceType)
            self.embededNavigationController.setViewControllers([getReadyVC], animated: true)
        }
    }



    //MARK: Connect to internet
    private func showConnectingToInternet() {
        DispatchQueue.main.async {
            let connectingVC = MeshSetupConnectToInternetViewController.loadedViewController()
            connectingVC.setup(didFinishScreen: self.didFinishConnectToInternetScreen, deviceType: self.targetDeviceType)
            self.embededNavigationController.pushViewController(connectingVC, animated: true)
        }
    }

    func didFinishConnectToInternetScreen() {
        self.flowManager.continueSetup()
    }


    func meshSetupDidRequestToFinishSetupEarly() {
        DispatchQueue.main.async {
            //flowManager.setAddOneMoreDevice(addOneMoreDevice: true)
            let earlyVC = MeshSetupFinishSetupEarlyViewController.loadedViewController()
            earlyVC.setup(didSelectDone: self.didSelectToFinishEarly, deviceName: self.targetDeviceName!)
            self.embededNavigationController.pushViewController(earlyVC, animated: true)
        }
    }

    func didSelectToFinishEarly(finishEarly: Bool) {
        flowManager.setFinishSetupEarly(finish: finishEarly )

        if (finishEarly) {
            //setup done
            self.dismiss(animated: true)
        }
    }





    private func showSelectOrCreateNetwork() {
        DispatchQueue.main.async {
            let networksVC = MeshSetupSelectOrCreateNetworkViewController.loadedViewController()
            networksVC.setup(didSelectGatewayNetwork: self.didSelectGatewayNetwork)
            self.embededNavigationController.pushViewController(networksVC, animated: true)
        }
    }

    func didSelectGatewayNetwork(network: MeshSetupNetworkInfo?) {
        self.didSelectNetwork = true
        self.selectedNetwork = network

        flowManager.setSelectOrCreateNetwork(selectedNetwork: selectedNetwork)
    }


    func meshSetupDidRequestToSelectOrCreateNetwork(availableNetworks: [Particle.MeshSetupNetworkInfo]) {
        NSLog("scan complete")

        //if by the time this returned, user has already selected the network, ignore the results of last scan
        if let vc = self.embededNavigationController.topViewController as? MeshSetupSelectOrCreateNetworkViewController {
            vc.setNetworks(networks: availableNetworks)

            //if no networks found = force instant rescan
            if (availableNetworks.count == 0) {
                rescanNetworks()
            } else {
                //rescan in 3seconds
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
                    [weak self] in
                    //only rescan if user hasn't made choice by now
                    self?.rescanNetworks()
                }
            }
        }
    }


    func meshSetupDidRequestToEnterNewNetworkNameAndPassword() {
        DispatchQueue.main.async {
            let networkNameVC = MeshSetupCreateNetworkNameViewController.loadedViewController()
            networkNameVC.setup(didEnterNetworkName: self.didEnterCreateNetworkName)
            self.embededNavigationController.pushViewController(networkNameVC, animated: true)
        }
    }

    func didEnterCreateNetworkName(networkName: String) {
        self.createNetworkName = networkName

        showCreateNetworkPassword()
    }


    private func showCreateNetworkPassword() {
        DispatchQueue.main.async {
            let networkPasswordVC = MeshSetupCreateNetworkPasswordViewController.loadedViewController()
            networkPasswordVC.setup(didEnterNetworkPassword: self.didEnterCreateNetworkPassword)
            self.embededNavigationController.pushViewController(networkPasswordVC, animated: true)
        }
    }

    func didEnterCreateNetworkPassword(networkPassword: String) {
        self.createNetworkPassword = networkPassword

        if let error = self.flowManager.setNewNetwork(name: self.createNetworkName!, password: self.createNetworkPassword!),
           let vc = self.embededNavigationController.topViewController as? MeshSetupCreateNetworkPasswordViewController{
            vc.setWrongInput(message: error.description)
        }
    }


    private func showCreateNetwork() {
        DispatchQueue.main.async {
            let createNetworkVC = MeshSetupCreatingNetworkViewController.loadedViewController()
            createNetworkVC.setup(didFinishScreen: self.createNetworkScreenDone, deviceType: self.targetDeviceType, deviceName: self.targetDeviceName)
            self.embededNavigationController.pushViewController(createNetworkVC, animated: true)
        }
    }

    func meshSetupDidCreateNetwork(network: MeshSetupNetworkInfo) {
        //make target device into a commissioner
        self.selectedNetwork = network
        self.didSelectNetwork = true

        self.commissionerDeviceType = self.targetDeviceType
        self.commissionerDeviceDataMatrixString = self.targetDeviceDataMatrixString
        self.selectedNetworkPassword = self.createNetworkPassword
    }

    func createNetworkScreenDone() {
        // simply do nothing. screen will be exited automatically
    }


    func meshSetupDidEnterState(state: MeshSetupFlowState) {
        log("flow setup entered state: \(state)")

        switch state {
            case .TargetDeviceReady:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupPairingProcessViewController {
                    vc.setSuccess()
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupPairingProcessViewController.setSuccess was attempted when it shouldn't be")
                }
            case .CommissionerDeviceReady:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupPairingCommissionerProcessViewController {
                    vc.setSuccess()
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupPairingCommissionerProcessViewController.setSuccess was attempted when it shouldn't be")
                }


            case .FirmwareUpdateProgress:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupFirmwareUpdateProgressViewController {
                    vc.setProgress(progress: Int(round(self.flowManager.targetDeviceFirmwareFlashProgress() ?? 0)))
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupFirmwareUpdateProgressViewController.setProgress was attempted when it shouldn't be")
                }
                break;
            case .FirmwareUpdateFileComplete:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupFirmwareUpdateProgressViewController {
                    vc.setFileComplete()
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupFirmwareUpdateProgressViewController.setFileComplete was attempted when it shouldn't be")
                }
                break;
            case .FirmwareUpdateComplete:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupFirmwareUpdateProgressViewController {
                    self.flowManager.pauseSetup()
                    vc.setFirmwareUpdateComplete()
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupFirmwareUpdateProgressViewController.setFirmwareUpdateComplete was attempted when it shouldn't be")
                }
                break;


            case .TargetDeviceScanningForNetworks:
                showScanNetworks()
            case .TargetGatewayDeviceScanningForNetworks:
                showSelectOrCreateNetwork()


            case .TargetDeviceConnectingToInternetStarted:
                showConnectingToInternet()
            case .TargetDeviceConnectingToInternetStep1Done, .TargetDeviceConnectingToInternetCompleted:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupConnectToInternetViewController {
                    if state == .TargetDeviceConnectingToInternetCompleted {
                        self.flowManager.pauseSetup()
                    }
                    vc.setState(state)
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupConnectToInternetViewController.setState was attempted when it shouldn't be")
                }


            case .JoiningNetworkStarted:
                showJoiningNetwork()
            case .JoiningNetworkStep1Done, .JoiningNetworkStep2Done, .JoiningNetworkCompleted:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupJoiningNetworkViewController {
                    if state == .JoiningNetworkCompleted {
                        self.flowManager.pauseSetup()
                    }

                    vc.setState(state)

                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupJoiningNetworkViewController.setState was attempted when it shouldn't be")
                }


            case .CreateNetworkStarted:
                showCreateNetwork()
            case .CreateNetworkStep1Done, .CreateNetworkStep2Done, .CreateNetworkStep3Done, .CreateNetworkCompleted:
                if let vc = self.embededNavigationController.topViewController as? MeshSetupCreatingNetworkViewController {
                    vc.setState(state)
                } else {
                    NSLog("!!!!!!!!!!!!!!!!!!!!!!! MeshSetupCreatingNetworkViewController.setState was attempted when it shouldn't be")
                }
            default:
                break;



        }
    }

    @IBAction func cancelTapped(_ sender: Any) {
        if let _ = sender as? MeshSetupFlowUIManager {
            self.flowManager.cancelSetup()
            self.dismiss(animated: true)
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: MeshSetupStrings.Prompt.CancelSetupTitle, message: MeshSetupStrings.Prompt.CancelSetupText, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: MeshSetupStrings.Action.CancelSetup, style: .default) { action in
                    self.cancelTapped(self)
                })

                alert.addAction(UIAlertAction(title: MeshSetupStrings.Action.ContinueSetup, style: .cancel) { action in
                    //do nothing
                })

                self.present(alert, animated: true)
            }
        }
    }


    func meshSetupError(error: MeshSetupFlowError, severity: MeshSetupErrorSeverity, nsError: Error?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: MeshSetupStrings.Prompt.ErrorTitle, message: error.description, preferredStyle: .alert)

            if (severity == .Fatal) {
                alert.addAction(UIAlertAction(title: MeshSetupStrings.Action.Ok, style: .default) { action in
                    self.cancelTapped(self)
                })
            } else {
                alert.addAction(UIAlertAction(title: MeshSetupStrings.Action.Retry, style: .default) { action in
                    self.flowManager.retryLastAction()
                })

                alert.addAction(UIAlertAction(title: MeshSetupStrings.Action.Cancel, style: .cancel) { action in
                    self.cancelTapped(self)
                })
            }

            self.present(alert, animated: true)
        }
    }


}
