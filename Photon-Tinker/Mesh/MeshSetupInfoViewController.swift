//
// Created by Raimundas Sakalauskas on 9/20/18.
// Copyright © 2018 Particle. All rights reserved.
//

import UIKit

class MeshSetupInfoViewController: MeshSetupViewController {

    @IBOutlet weak var titleLabel: MeshLabel!

    @IBOutlet var textLabels: [MeshLabel]!
    @IBOutlet var textLabelValues: [String]!

    @IBOutlet weak var continueButton: MeshSetupButton!

    internal var setupMesh:Bool?
    internal var callback: (() -> ())!

    func setup(didFinishScreen: @escaping () -> (), setupMesh:Bool?, networkName: String? = nil, deviceType: ParticleDeviceType? = nil, deviceName: String? = nil) {
        self.callback = didFinishScreen

        self.networkName = networkName
        self.deviceType = deviceType
        self.deviceName = deviceName

        self.setupMesh = setupMesh
    }

    override func setStyle() {
        titleLabel.setStyle(font: MeshSetupStyle.RegularFont, size: MeshSetupStyle.LargeSize, color: MeshSetupStyle.PrimaryTextColor)

        for label in textLabels {
            label.setStyle(font: MeshSetupStyle.RegularFont, size: MeshSetupStyle.RegularSize, color: MeshSetupStyle.PrimaryTextColor)
        }
    }

    internal func setLabelValues() {
        let tfCount = textLabels.count
        let valueCount = textLabelValues.count


        for i in 0 ..< valueCount {
            textLabels[i].isHidden = false
            textLabels[i].text = textLabelValues[i]
        }

        //hide excessive text fields
        for i in valueCount ..< tfCount {
            textLabels[i].isHidden = true
        }
    }

    internal func fadeContent() {
        self.isBusy = true
        UIView.animate(withDuration: 0.25) { () -> Void in
            self.titleLabel.alpha = 0.5
            self.continueButton.alpha = 0.5

            for textField in self.textLabels {
                textField.alpha = 0.5
            }
        }
    }

    internal func unfadeContent(animated: Bool) {
        if (animated) {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.titleLabel.alpha = 1
                self.continueButton.alpha = 1

                for textField in self.textLabels {
                    textField.alpha = 1
                }
            }
        } else {
            self.titleLabel.alpha = 1
            self.continueButton.alpha = 1

            for textField in self.textLabels {
                textField.alpha = 1
            }

            self.view.setNeedsDisplay()
        }
    }

    @IBAction func continuePressed(_ sender: Any) {
        ParticleSpinner.show(view)
        fadeContent()

        callback()
    }

    override func resume(animated: Bool) {
        super.resume(animated: animated)

        ParticleSpinner.hide(view, animated: animated)
        unfadeContent(animated: true)
        isBusy = false
    }
}
