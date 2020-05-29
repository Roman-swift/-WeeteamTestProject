//
//  CheckInternetConnect.swift
//  Weeteam
//
//  Created by Admin on 5/29/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
