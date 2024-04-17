//
//  NetworkError.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case noHTTP
    case statusCode(Int)
    case general(Error)
    case json
    
    var description: String {
        switch self {
        case .noHTTP:
            "Falló la conexión. "
        case .statusCode(let int):
            "Error status code \(int)."
        case .general(let error):
            "Error general \(error.localizedDescription)."
        case .json:
            "Error con la decodificación del Json."
        }
    }
}
