//
// Created by Raimundas Sakalauskas on 9/20/18.
// Copyright © 2018 Particle. All rights reserved.
//

import UIKit

class MeshSetupScanCommissionerStickerViewController: MeshSetupScanStickerViewController {

//    static var nibName: String {
//        return "MeshSetupScanStickerView"
//    }

    override func setContent() {
        titleLabel.text = MeshSetupStrings.ScanCommissionerSticker.Title
        textLabel.text = MeshSetupStrings.ScanCommissionerSticker.Text
    }
}
