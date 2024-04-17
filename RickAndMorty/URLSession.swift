//
//  URLSession.swift
//  MangasLibrary
//
//  Created by Yery Castro on 19/3/24.
//

import SwiftUI

extension URLSession {
    func getData(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noHTTP }
            return (data, httpResponse)
        } catch {
            throw NetworkError.general(error)
        }
    }
}
