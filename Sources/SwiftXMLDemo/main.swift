//
//  main.swift
//
//  Created 2021 by Stefan Springer, https://stefanspringer.com
//  License: Apache License 2.0

import Foundation
import SwiftXMLInterfaces
import SwiftXMLParser
import SwiftXML

let start = DispatchTime.now()

var sourcePath: String? = nil
var targetPath: String? = nil

if CommandLine.arguments.count > 4 {
    print("too many arguments"); exit(1)
}

var waitAfterRead = false
var printXML = false

CommandLine.arguments.dropFirst().forEach { argument in
    if argument.hasPrefix("-") {
        if argument == "-w" {
            waitAfterRead = true
        }
        else if argument == "-p" {
            printXML = true
        }
        else {
            print("unkown argument \"\(argument)\""); exit(1)
        }
    }
    else if sourcePath == nil {
        sourcePath = argument
        print("source: \(sourcePath ?? "")")
    }
    else if targetPath == nil {
        targetPath = argument
        print("target: \(targetPath ?? "")")
    }
    else {
        print("too many arguments!"); exit(1)
    }
}

class MyInternalEntityResolver: InternalEntityResolver {
    func resolve(entityName: String, attributeContext: String?, attributeName: String?) -> String? {
        return attributeContext != nil ? "[\(entityName)]" : nil
    }
}

class MyXMLFormatter: SwiftXML.DefaultXMLFormatter {
    
    override init() {
        super.init()
        setLinebreak(linebreak: "\r\n")
    }
    
    override public func sortedDeclarationsInInternalSubset(document: SwiftXML.XMLDocument) -> [XMLDeclarationInInternalSubset] {
        return document.declarationsInInternalSubset
    }
    
    override public func attributeValue(value: String) -> String {
        return SwiftXMLInterfaces.escapeAll(value)
    }
    
    override public func text(text: String) -> String {
        return SwiftXMLInterfaces.escapeAll(text)
    }
}

if let theSourcePath = sourcePath {
    do {
        let document = try parseXML(path: theSourcePath, internalEntityResolver: MyInternalEntityResolver())
        if waitAfterRead {
            print("XML is read, press enter to write"); _ = readLine()
        }
        if printXML {
            document.echo(formatter: MyXMLFormatter())
        }
        if let theTargetPath = targetPath {
            document.write(toFile: theTargetPath, formatter: MyXMLFormatter())
        }
    }
    catch {
        print("ERROR: \(error.localizedDescription)")
    }
}
else {
    print("nothing to do")
}

if !waitAfterRead {
    let end = DispatchTime.now()
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000
    print("program ended after \(timeInterval) s")
}
