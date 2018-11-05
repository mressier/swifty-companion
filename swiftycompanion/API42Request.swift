//
//  API42ConnectionRequest.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation
import Alamofire

class API42Request : NSObject
{
    let UID = "6fe870844db8183068f379610446ce972c3dd97a2622fead948a78332e3189a8"
    let SECRET = "229be1ace7d9a0a03eec6682e75cca80b730c7b6a10bac49dc4850c3d5ae5a50"
    var token:String?
    
    var delegate: API42RequestDelegate?
    
    private var tryToken:Int = 0
    
    init(delegate: API42RequestDelegate?)
    {
        super.init()
        self.delegate = delegate
    }
    
    open func getUser(login: String)
    {
        if let token = self.token
        {
            let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
                                         "Authorization" : token];
            
            Alamofire.request("https://api.intra.42.fr/v2/users/" + login,
                              method: .get,
                              headers: header)
                .validate(statusCode: 200..<300)
                .responseJSON
                {
                    response in
                    
                    switch response.result
                    {
                        case .success:
                            if let res_user = response.result.value as? NSDictionary {
                                if res_user.count == 0 {
                                    self.delegate?.requestFailed(error: "user not found")
                                }
                                else
                                {
                                    let user = User()
                                    user.initWithDictionnary(dictionary: res_user)
                                    self.delegate?.requestSuccess(response: user)
                                }
                            }
                            else {
                                self.delegate?.requestFailed(error: "API return error")
                            }
                        
                        case .failure (let error):
                            let status = response.response?.statusCode ?? 500
                            switch status
                            {
                                case 401:
                                    print("retry to get token");
                                    if (self.tryToken >= 2) {
                                        self.delegate?.requestFailed(error: "Cannot get a valid token :(")
                                    }
                                    else {
                                        self._getAPI42Token(nextLogin: login)
                                        return ;
                                    }
                                
                                case 404:
                                    self.delegate?.requestFailed(error: "user not found")
                                
                                default:
                                    self.delegate?.requestFailed(error: error.localizedDescription)
                            }
                        
                    }
                    self.tryToken = 0
                }
        }
        else {
            self._getAPI42Token(nextLogin: login)
        }
    }
    
    /* PRIVATE */
    
    private func _getAPI42Token(nextLogin: String)
    {
        let parameters: Parameters = ["grant_type" : "client_credentials",
                                      "client_id" : self.UID,
                                      "client_secret" : self.SECRET]
        self.tryToken += 1
        Alamofire.request("https://api.intra.42.fr/oauth/token",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON
            {
                response in
                
                switch response.result
                {
                    case .success:
                        if let dic = response.result.value as? NSDictionary {
                            if let token = self._getTokenFromResponse(dic: dic) {
                                print("token: " + token)
                                self.token = token
//                                self.token = "toto"
                                self.getUser(login: nextLogin)
                            }
                            else {
                                self.delegate?.requestFailed(error: "Cannot get token")
                            }
                        }
                    
                    case .failure (let error):
                        self.delegate?.requestFailed(error: error.localizedDescription)
                }
            }
    }
    
    private func _getTokenFromResponse(dic: NSDictionary) -> String?
    {
        if let token_type = dic["token_type"] as? String {
            if token_type == "bearer" {
                if let token = dic["access_token"] as? String {
                    self.token = "Bearer " + token
                    return (self.token)
                }
            }
        }
        return nil
    }
}
