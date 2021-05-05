//
//  NetworkController.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

class NetworkController {
    
    private var model: GetRequestModel? = nil
    private var error: Error? = nil
    
    public func fetchData(tableView: UITableView) -> (GetRequestModel?, Error?){
        guard let url = URL(string: "https://gist.githubusercontent.com/nivol05/530e2293fa8dcba92fd26677779567a8/raw/31f2d8bf29b39c9f0318a64b83411a16e743ceb6/PlacesQuiz.json") else { return (nil, nil)}
        var request = URLRequest(url: url)
        let semaphore = DispatchSemaphore (value: 0)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                semaphore.signal()
                self.error = error
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.model = try decoder.decode(GetRequestModel.self, from: data)
                print(self.model.debugDescription)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            } catch let e {
                self.error = e
                print("Failed to convert Data!")
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return (model, error)
    }
}
