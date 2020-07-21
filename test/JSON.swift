//
//  JSON.swift
//  test
//
//  Created by Юрий Ни on 21.07.2020.
//  Copyright © 2020 Yura Ni. All rights reserved.
//

import Foundation

struct jsonData:Decodable {
    let data:[dataInfo]
    let view:[String]
}
struct dataInfo:Decodable {
    let name:String?
    let data: data?
}
struct data:Decodable{
    let text:String?
    let url:String?
    let selectedId:Int?
    let variants:[variants]?
}
struct variants:Decodable {
    let id:Int?
    let text:String?
}
