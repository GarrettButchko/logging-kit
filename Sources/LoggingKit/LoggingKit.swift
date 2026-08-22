import Foundation

public struct AppLogger {

    public static func error(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("❌", level: "ERROR", message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func error(
        _ message: String,
        _ error: Error,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("❌", level: "ERROR", message: "\(message): \(error.localizedDescription)", tag: tag, file: file, function: function, line: line)
    }

    public static func warning(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("⚠️", level: "WARNING", message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func success(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("✅", level: "SUCCESS", message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func info(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("ℹ️", level: "INFO", message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func debug(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log("🔧", level: "DEBUG", message: message, tag: tag, file: file, function: function, line: line)
    }

    // MARK: - Private

    private static func log(
        _ emoji: String,
        level: String,
        message: String,
        tag: String?,
        file: String,
        function: String,
        line: Int
    ) {
        let fileName = file.split(separator: "/").last.map(String.init) ?? file
        let source = tag ?? fileName
        print("\(emoji) [\(level)] [\(source):\(line)] \(function) → \(message)")
    }
}
