//
//  URLRequest.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

extension URLRequest {

    
    static func post<JSON>(url: URL, data: JSON, method: String = "POST") -> URLRequest where JSON: Codable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
    
    
    static func getCharactersRequest(page: Int) -> URLRequest {
        var components = URLComponents(url: URL.urlCharacters, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "page", value: String(page))]
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func getLocationsRequest(page: Int) -> URLRequest {
        var components = URLComponents(url: URL.urlLocations, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "page", value: String(page))]
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func getEpisodesRequest(page: Int) -> URLRequest {
        var components = URLComponents(url: URL.urlEpisodes, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "page", value: String(page))]
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
 
}
