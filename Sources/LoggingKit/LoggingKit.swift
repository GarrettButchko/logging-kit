import Foundation
import SwiftUI

public struct LogType: Sendable, Hashable {
    public let level: LogLevel
    public let title: String
    public let emoji: String
    public let badgeColor: Color

    public init(level: LogLevel, title: String, emoji: String, badgeColor: Color) {
        self.level = level
        self.title = title
        self.emoji = emoji
        self.badgeColor = badgeColor
    }
}

public enum LogLevel: String, Comparable, CaseIterable, Sendable {
    case debug = "DEBUG"
    case info = "INFO"
    case success = "SUCCESS"
    case warning = "WARNING"
    case error = "ERROR"

    private var order: Int {
        switch self {
        case .debug: return 0
        case .info: return 1
        case .success: return 2
        case .warning: return 3
        case .error: return 4
        }
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.order < rhs.order
    }

    public var title: String {
        rawValue.capitalized
    }

    public var emoji: String {
        switch self {
        case .debug: return "🔧"
        case .info: return "ℹ️"
        case .success: return "✅"
        case .warning: return "⚠️"
        case .error: return "❌"
        }
    }

    public var badgeColor: Color {
        switch self {
        case .debug: return .secondary
        case .info: return .blue
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        }
    }

    public var logType: LogType {
        LogType(level: self, title: title, emoji: emoji, badgeColor: badgeColor)
    }
}

public struct AppLogger {

    nonisolated(unsafe) public static var minimumLevel: LogLevel = .info
    nonisolated(unsafe) public static var logHandler: (@Sendable (LogLevel, String) -> Void)?

    public static func error(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .error, message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func error(
        _ message: String,
        _ error: Error,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .error, message: "\(message): \(error.localizedDescription)", tag: tag, file: file, function: function, line: line)
    }

    public static func warning(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .warning, message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func success(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .success, message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func info(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .info, message: message, tag: tag, file: file, function: function, line: line)
    }

    public static func debug(
        _ message: String,
        tag: String? = nil,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        log(level: .debug, message: message, tag: tag, file: file, function: function, line: line)
    }

    // MARK: - Private

    private static func log(
        level: LogLevel,
        displayLevel: String? = nil,
        message: String,
        tag: String?,
        file: String,
        function: String,
        line: Int
    ) {
        guard level >= minimumLevel else { return }

        let rawFileName = file.split(separator: "/").last.map(String.init) ?? file
        let fileName = rawFileName.hasSuffix(".swift") ? String(rawFileName.dropLast(6)) : rawFileName
        let source = tag ?? fileName
        let label = displayLevel ?? level.rawValue
        print("\(level.emoji) [\(label)] [\(source):\(line)] \(function) → \(message)")
        logHandler?(level, message)
    }
}
