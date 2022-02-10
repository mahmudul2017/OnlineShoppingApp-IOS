//
//  ChartViewModel.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 10/2/22.
//

import Foundation
import SwiftUI

class ChartViewModel: ChartViewModelSample {
    @Published var chartData: [ChartAssetProvider] = [
        ChartAssetModel(chartAsset: .cash, percentage: 0.4, description: "CASH", color: Color("cGrey")),
        ChartAssetModel(chartAsset: .equity, percentage: 0.2, description: "STOCKS", color: Color("cBlue")),
        ChartAssetModel(chartAsset: .bond, percentage: 0.2, description: "BONDS", color: Color("cRed")),
        ChartAssetModel(chartAsset: .realEstate, percentage: 0.2, description: "REAL ESTATE", color: Color("cGreen"))
    ]
}

class ChartCarViewModel: ChartViewModelSample {
    @Published var chartData: [ChartAssetProvider] = [
        ChartCarModel(percentage: 0.5, description: "LAND ROVER", color: Color("cGrey")),
        ChartCarModel(percentage: 0.3, description: "LAMBORGHINI", color: Color("cBlue")),
        ChartCarModel(percentage: 0.2, description: "FERRARI", color: Color("cRed")),
    ]
}
