//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 14/12/2019.
//

import Foundation

extension PlatformLookup {
  public enum DeviceFamily : String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case appleTV = "Apple TV"
    case appleWatch = "Apple Watch"
    
    var os : String {
      get {
        switch self {
        case .iPhone, .iPad: return "iOS"
        case .appleTV: return "tvOS"
        case .appleWatch: return "watchOS"
        }
      }
    }
  }
}
