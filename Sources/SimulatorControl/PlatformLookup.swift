//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 04/11/2019.
//

import Foundation

public final class PlatformLookup {
  public typealias DeviceFilter = (_ device : Device) -> Bool
  public typealias RuntimeFilter = (_ device : Runtime) -> Bool
  static var shared : PlatformLookup? = nil
  let simctl : SimulatorControl

  private init?(_ data: Data) {
    do {
      simctl = try JSONDecoder().decode(SimulatorControl.self, from: data)
    } catch {
      print(error)
      return nil
    }
  }
    
  /// <#Description#>
  /// - Parameter data: <#data description#>
  static public func instanciate(_ data: Data) {
    PlatformLookup.shared = PlatformLookup(data)
  }  
}
