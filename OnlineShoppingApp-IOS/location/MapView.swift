//
//  MapView.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 14/2/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject private var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()

        map.showsUserLocation = true
        map.delegate = context.coordinator
        
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

