//
//  ImageURL.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

enum ImageURL{
    static func poster(path:String?, size:String = "w500") -> URL? {
        guard let path, !path.isEmpty else {return nil}
        return APIConfig.imageBaseURL?.appendingPathComponent(size).appendingPathComponent(path)
    }
}
