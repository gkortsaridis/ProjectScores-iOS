//
//  ApiServices.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 10/11/2024.
//

import Alamofire

struct APIServices {
	
	private static let BASE_URL = "https://v1.basketball.api-sports.io/"
	public static let shared = APIServices()
	
	func retrieveCountries(
		success: @escaping (_ result: ResponseCountries?) -> Void,
		failure: @escaping (_ failureMsg: FailureMessage) -> Void)
	{
		var headers = HTTPHeaders()
		headers["content-type"] = "application/json"
		headers["x-apisports-key"] = "bb577ccc9c0bb3b6f6a5964b041b1b54"
		
		APIManager.shared.callAPI(serverURL: APIServices.BASE_URL+"countries", method: .get, headers: headers, parameters: nil, success: { response in
			do {
				if let data = response.data {
					success(try JSONDecoder().decode(ResponseCountries.self, from: data))
				}
			} catch {
				failure(FailureMessage(error.localizedDescription))
			}
		}, failure: { error in failure(FailureMessage(error)) })
  }
}
