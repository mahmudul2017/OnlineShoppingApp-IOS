//
//  ChartShapeView..swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import SwiftUI

struct PieceOfPieShape: Shape {
    let startDegree: Double
    let endDegree: Double
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            p.move(to: center)
            p.addArc(center: center, radius: rect.width / 2, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
            p.closeSubpath()
        }
    }
}

struct PieChartView<T>: View where T: ChartViewModelSample {
    @State var selectPieChartElement: Int? = nil
    @ObservedObject var viewModel: T
    let action: ((ChartAssetProvider) -> Void)?
    
    var body: some View {
        ZStack {
            ForEach(0..<viewModel.chartData.count) { index in
                let currentData = viewModel.chartData[index]
                let currentEndDegree = currentData.percentage * 360
                let lastDegree = viewModel.chartData.prefix(index).map{ $0.percentage }.reduce(0, +) * 360
                
                ZStack {
                    PieceOfPieShape(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree)
                        .fill(currentData.color)
                        .scaleEffect(index == selectPieChartElement ? 1.2 : 1.0)
                    
                    GeometryReader { geoMetry in
                        Text(currentData.description)
                            .font(.custom("Avenir", size: 14))
                            .foregroundColor(.white)
                            .position(getChartLabel(in: geoMetry.size, for: lastDegree + (currentEndDegree / 2)))
//                            .padding(.leading, 12)
//                            .padding(.trailing, 16)
                        
                        Text(String(currentData.percentage))
                            .font(.custom("Avenir", size: 20))
                            .foregroundColor(.white)
                            .position(getChartLabel(in: geoMetry.size, for: lastDegree + (currentEndDegree / 2)))
                            .padding(.top, 24)
                    }
                }
                .onTapGesture(count: 1, perform: {
                    withAnimation(.easeInOut(duration: 2)) {
                        if index == selectPieChartElement {
                            self.selectPieChartElement = nil
                        } else {
                            self.selectPieChartElement = index
                            action?(currentData)
                        }
                    }
                })
            }
//            PieceOfPieShape(startDegree: 0, endDegree: 90)
//                .fill(Color.orange)
//
//            PieceOfPieShape(startDegree: 90, endDegree: 190)
//                .fill(Color.blue)
        }
    }
        
        private func getChartLabel(in geoSize: CGSize, for degree: Double) -> CGPoint {
            let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
            let redius = geoSize.width / 3
            
            let yCoordinate = redius * sin(CGFloat(degree) * (CGFloat.pi / 180))
            let xCoordinate = redius * cos(CGFloat(degree) * (CGFloat.pi / 180))
            return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
        }
}

struct ChartShapeView: View {
    var body: some View {
        VStack {
            PieChartView(viewModel: ChartViewModel()) { assetData in
                print(assetData)
            }
            .padding()
            
            PieChartView(viewModel: ChartCarViewModel()) { carData in
                print(carData)
            }
            .padding()
        }
        .padding()
    }
}

struct ChartShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ChartShapeView()
    }
}
