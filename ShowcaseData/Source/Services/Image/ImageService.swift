//
//  ImageService.swift
//  ShowcaseData
//
//  Created by Lukasz Spaczynski on 01/12/2021.
//

import RxSwift
import UIKit

public protocol ImageService {
    func getRemoteImage(_ url: URL) -> Observable<Result<UIImage, Error>>
}
