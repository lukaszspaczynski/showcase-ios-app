//
//  DataAssembly.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 20/11/2021.
//

import ShowcaseData
import Swinject
import SwinjectAutoregistration

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(BioWebEndpoint.self) { _ in Endpoints.shared }
        container.register(AvatarEndpoint.self) { _ in Endpoints.shared }
        container.autoregister(RestClient.self, initializer: ConcreteRestClient.init)
        container.autoregister(BioWebDataSource.self, initializer: ConcreteBioWebDataSource.init)
        container.autoregister(BioRepository.self, initializer: ConcreteBioRepository.init)
        container.autoregister(RichTextTemplatesLocalDataSource.self, initializer: ConcreteRichTextTemplatesLocalDataSource.init)
        container.autoregister(RichTextTemplatesRepository.self, initializer: ConcreteRichTextTemplatesRepository.init)
        container.autoregister(ImageService.self, initializer: ConcreteImageService.init)
        container.autoregister(ImageFilterService.self, initializer: ConcreteImageFilterService.init)
    }
}
