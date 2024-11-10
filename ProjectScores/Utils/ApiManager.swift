//
//  ApiManager.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 10/11/2024.
//

import Alamofire
public typealias FailureMessage = String

public class APIManager {
  public static let shared = APIManager()
  
  func callAPI(serverURL: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parameters: Parameters? = nil, success: @escaping ((AFDataResponse<Any>) -> Void), failure: @escaping ((FailureMessage) -> Void)) {
	
	  guard let url = URLComponents(string: "\(serverURL)") else {
	  failure("Invalid URL")
	  return
	}
	// Network request
	AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
	  .responseJSON { response in
		switch response.result {
		case .success:
		  success(response)
		case let .failure(error):
		  failure(error.localizedDescription)
		}
	  }
  }
}
