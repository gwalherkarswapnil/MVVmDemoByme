//
//  NetworkManager.swift
//  MVVmDemoVirtual
//
//  Created by Apple on 30/12/22.
//

import Foundation

import UIKit

/// This is the object we're looking to get from the endpoint
struct User: Codable {
    let id: String
    let createdAt: Date
    let name: String
    let avatar: URL
}

/// This is our network class, it will handle all our requests
class NetworkManager {

    /// These are the errors this class might return
    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }

    /// The request method you like to use
    enum HttpMethod: String {
        case get
        case post

        var method: String { rawValue.uppercased() }
    }

    /// Request data from an endpoint
    /// - Parameters:
    ///   - url: the URL
    ///   - httpMethod: The HTTP Method to use, either get or post in this case
    ///   - completion: The completion closure, returning a Result of either the generic type or an error
    func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {

        // Because URLSession returns on the queue it creates for the request, we need to make sure we return on one and the same queue.
        // You can do this by either create a queue in your class (NetworkManager) which you return on, or return on the main queue.
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        // Create the request. On the request you can define if it is a GET or POST request, add body and more.
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            // First check if we got an error, if so we are not interested in the response or data.
            // Remember, and 404, 500, 501 http error code does not result in an error in URLSession, it
            // will only return an error here in case of e.g. Network timeout.
            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            // Lets check the status code, we are only interested in results between 200 and 300 in statuscode. If the statuscode is anything
            // else we want to return the error with the statuscode that was returned. In this case, we do not care about the data.
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            // Now that all our prerequisites are fullfilled, we can take our data and try to translate it to our generic type of T.
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(users))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }

        // Start the request
        urlSession.resume()
    }
}

