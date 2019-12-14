//
//  File.swift
//  
//
//  Created by Jeffrey Macko on 14/12/2019.
//

import Foundation

public enum ShellError: Error {
  case pipeOutputFailedToDecode
}

public func shell(_ command: String) throws -> String {
  let task = Process()
  task.launchPath = "/bin/bash"
  task.arguments = ["-c", command]
  
  let pipe = Pipe()
  task.standardOutput = pipe
  task.launch()
  
  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  guard let output: String = String(data: data, encoding: .utf8) else { throw(ShellError.pipeOutputFailedToDecode) }
  
  return output
}
