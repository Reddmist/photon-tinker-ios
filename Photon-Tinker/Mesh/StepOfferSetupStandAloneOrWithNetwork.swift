//
// Created by Raimundas Sakalauskas on 2019-03-05.
// Copyright (c) 2019 spark. All rights reserved.
//

import Foundation

class StepOfferSetupStandAloneOrWithNetwork : MeshSetupStep {
    override func start() {
        guard let context = self.context else {
            return
        }

       context.delegate.meshSetupDidRequestToSelectStandAloneOrMeshSetup(self)
    }

    func setSelectStandAloneOrMeshSetup(meshSetup: Bool) -> MeshSetupFlowError? {
        guard let context = self.context else {
            return nil
        }

        context.userSelectedToSetupMesh = meshSetup

        self.stepCompleted()

        return nil
    }

    override func rewindTo(context: MeshSetupContext) {
        super.rewindTo(context: context)

        guard let context = self.context else {
            return
        }

        context.userSelectedToSetupMesh = nil
    }
}
