//
//  API42RequestDelegate.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation

protocol API42RequestDelegate {
    func requestSuccess(response: Any)
    func requestFailed(error: String)
}
