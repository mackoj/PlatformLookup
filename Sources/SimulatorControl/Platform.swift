//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 26/11/2019.
//

import Foundation

public struct Platform : Equatable, Codable {
  let device: Device
  let runtime: Runtime
}
