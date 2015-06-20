//
//  Entry.swift
//  MovileExercicio
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//
import Argo
import Runes

struct Entry {
    let content: String
    let contentSnippet: String
    let link: NSURL
    let publishedDate: NSDate
    let title: String
    
}

extension Entry{
    static func create(content: String)(contentSnippet: String)(link: NSURL)(publishedDate: NSDate)(title: String) -> Entry {
        return self(content: content , contentSnippet: contentSnippet, link: link, publishedDate: publishedDate, title: title)
    }
}


extension NSDate: Decodable {
    
    public static func decode(j: JSON) -> Decoded<NSDate> {
        switch j {
        case let .String(s):
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            
            return .fromOptional(formatter.dateFromString(s))
        default: return .TypeMismatch("\(j) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

extension NSURL: Decodable {
    
    public static func decode(j: JSON) -> Decoded<NSURL> {
        switch j {
        case let .String(s):
            
            return .fromOptional(NSURL(string: s))
        default: return .TypeMismatch("\(j) is not a String") // Provide an Error message for a string type mismatch
        }
    }
}

extension Entry: Decodable {
    static func decode(j: JSON) -> Decoded<Entry> {
        return Entry.create
            <^> j <| "content"
            <*> j <| "contentSnippet"
            <*> j <| "link"
            <*> j <| "publishedDate"
            <*> j <| "title"
    }
}




