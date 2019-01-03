//
//  VoxosonusTests.swift
//  VoxosonusTests
//
//  Created by Heerco Grond on 18/12/2018.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import XCTest
import Voxosonus

class VoxosonusTests: XCTestCase, VoxosonusDelegate {
    
    let model = Voxosonus()
    var stage: Int = 0;
    
    override func setUp() {
        model.delegate = self
    }
    
    func testAddTags(){
        let tags: [Tag] = [Tag(tagname: "capabilities"), Tag(tagname: "about_VA"), Tag(tagname: "system_reliance")]
        
        model.subscribeTags(tags: tags)
        
    }
    
    func testCleanTags(){
        model.cleanTags()
    }
    
    func testEmptyTags(){
        model.analyze(sentence: "do you tell the truth")
        model.analyze(sentence: "what is my speed")
        model.analyze(sentence: "what's your name?")
    }
    
    func testSubscribedTags(){
        stage = 2
        
        let tags: [Tag] = [Tag(tagname: "capabilities"), Tag(tagname: "about_VA"), Tag(tagname: "system_reliance")]
        
        model.subscribeTag(tag: tags[0])
        model.subscribeTag(tag: tags[1])
        model.subscribeTag(tag: tags[2])
        
        model.analyze(sentence: "do you tell the truth")
        model.analyze(sentence: "what is my speed")
        model.analyze(sentence: "what's your name?")
    }
    
    func labelFound(label: Tag) {
        if(stage == 1){
            XCTAssertTrue(label.value == "undefined")
        } else if (stage == 2){
            XCTAssertFalse(label.value == "undefined")
        }
    }
}
