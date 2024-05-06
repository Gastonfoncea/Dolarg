//
//  DolarChartModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 06/05/2024.
//

import Foundation

struct DolarChartModel: Identifiable {
    var id = UUID().uuidString
    var fecha: String
    var monto: Int
    
}
