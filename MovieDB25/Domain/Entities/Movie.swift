//
//  Movie.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

struct Movie: Identifiable,Decodable, Hashable{
    let id:Int
    let title:String
    let overview:String?
    let posterPath:String?
    let releaseDate:String?
    let voteAverage:Double?
}
