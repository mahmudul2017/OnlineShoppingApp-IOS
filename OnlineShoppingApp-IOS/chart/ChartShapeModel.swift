//
//  ChartShapeModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 10/2/22.
//

import Foundation
import SwiftUI

protocol ChartAssetProvider {
    var percentage: Double { get }
    var description: String { get }
    var color: Color { get }
}

protocol ChartViewModelSample: ObservableObject {
    var chartData: [ChartAssetProvider] { get }
}

enum ChartAsset {
    case equity, cash, bond, realEstate
}

struct ChartAssetModel: ChartAssetProvider {
    let chartAsset: ChartAsset
    let percentage: Double
    let description: String
    let color: Color
}

struct ChartCarModel: ChartAssetProvider {
    let percentage: Double
    let description: String
    let color: Color
}
