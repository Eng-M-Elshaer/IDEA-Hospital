//
//  Errors.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import Foundation

// MARK: - Errors
struct Errors: Decodable, Loopable {
    
    // MARK:- Login
    var username, password, name, email, oldPassword: [String]?
    
    // MARK:- Appointment
    var appointment: [String]?
    var patientName: [String]?
    var voucher: [String]?
    var comment: [String]?
    var rating: [String]?
    
    // MARK:- Send Message
    var message: [String]?
    
    enum CodingKeys: String, CodingKey {
        case username, password, name, email
        case oldPassword = "old_password"
        case appointment
        case patientName = "patient_name"
        case voucher
        case comment
        case rating
        //send message
        case message
    }

    // MARK:- Public Methods
    func formattedErrors() -> String {
        var messages = [String]()
        do {
            for (_, message) in try self.allProperties() {
                if let message = (message as? [String])?.first {
                    messages.append(message)
                }
            }
            var formattedMessage = ""
            for message in messages {
                formattedMessage += message + "\n"
            }
            return formattedMessage.trimmed
        } catch {
            print(error)
            return ""
        }
    }
}

// MARK:- Loopable
protocol Loopable {
    func allProperties() throws -> [String: Any]
}

extension Loopable {
    func allProperties() throws -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        // Optional check to make sure we're iterating over a struct or class
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }
        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            result[property] = value
        }
        return result
    }
}
