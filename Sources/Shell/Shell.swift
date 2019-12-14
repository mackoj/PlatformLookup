import Foundation

/// <#Description#>
public enum ShellError: Error { case pipeOutputFailedToDecode }

/// <#Description#>
/// - Parameter command: <#command description#>
public func shell(_ command: String) throws -> String {
  let task = Process()
  task.launchPath = "/bin/bash"
  task.arguments = ["-c", command]
  return try performShellOperation(task)
}

/// <#Description#>
/// - Parameters:
///   - command: <#command description#>
///   - arguments: <#arguments description#>
public func shell(_ command: String, arguments: [String]) throws -> String {
  let task = Process()
  task.launchPath = "/bin/bash"
  task.arguments = arguments
  return try performShellOperation(task)
}

// MARK: - Private

/// <#Description#>
/// - Parameter task: <#task description#>
private func performShellOperation(_ task: Process) throws -> String {
  let pipe = Pipe()
  task.standardOutput = pipe
  task.launch()

  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  guard let output:String = String(data: data, encoding: .utf8) else {
    throw (ShellError.pipeOutputFailedToDecode)
  }

  return output
}
