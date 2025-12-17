//
//  PagedResponse.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

struct PagedResponse<T:Decodable>:Decodable{
    let page:Int
    let totalPages:Int
    let totalResults:Int
    let results:[T]
}
