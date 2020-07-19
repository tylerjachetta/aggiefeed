//
//  DataRequest.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/17/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//

import Foundation

enum CellsError:Error {
    case failedDataProcessing
    case failedDataRetrieval
}

struct CellsRequest {
    let resourceURL:URL
    
    init() {
        let resourceString = "https://aggiefeed.ucdavis.edu/api/v1/activity/public?s=0?l=25"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getData(completion: @escaping(Result<[Cell], CellsError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.failedDataRetrieval))
                return
            }
            do {
                let decoder = JSONDecoder()
                let cellJson = try decoder.decode([Cell].self, from: jsonData)
                completion(.success(cellJson))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.failedDataProcessing))
            }
        }
        dataTask.resume()
    }
}


