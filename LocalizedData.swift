//
//  LocalizedData.swift
//  FRCScoreSheet
//
//  Created by Austin Bennett on 8/21/16.
//  Copyright © 2016 Austin Bennett. All rights reserved.
//

import Foundation

public class LocalizedData {
    private var TeamNumbersArray:[Int] = []
    private var matchData:[[Int]] = []
    private var pitScouting:[[Any]] = []
    private var EventName = ""
    static let localizedData = LocalizedData()
    init() {
        
    }
    
    public func addPitScout(teamNumber:Int, robotImageLocation:String, robotWeight:Int, robotPosition:Int, robotHeight:Int, robotWidth:Int, robotDepth:Int) {
        pitScouting += [[teamNumber,robotImageLocation,robotWeight,robotPosition,robotHeight,robotWidth,robotDepth]]
    }
    
    public func addScoreData(teamNumber:Int, matchNumber:Int, autoReachDef:Bool, autoCrossDef:Bool, autoLowGoal:Int, autoHighGoal:Int, teleopCrossDef:Int, teleopLowTower:Int, teleopHighTower:Int, teleopChallengedTower:Bool, teleopScaledTower:Bool, foul:Int) {
        
        var teleopChallengedTower = teleopChallengedTower
        if(teleopChallengedTower && teleopScaledTower) {
            teleopChallengedTower = false
        }
        
        var autoCrossDefense:Bool
        if(!autoReachDef && autoCrossDef) {
            autoCrossDefense = false
        } else {
            autoCrossDefense = autoCrossDef
        }
        
        let autoDefReach = scoreDataConverter(something: autoReachDef)
        let autoDefCross = scoreDataConverter(something: autoCrossDefense)
        let teleopTowerChallenged = scoreDataConverter(something: teleopChallengedTower)
        let teleopTowerScaled = scoreDataConverter(something: teleopScaledTower)
        let currentPosition = matchData.count
        matchData += [[teamNumber,matchNumber,autoDefReach,autoDefCross,autoLowGoal,autoHighGoal,teleopCrossDef,teleopLowTower,teleopHighTower,teleopTowerChallenged,teleopTowerScaled,foul,currentPosition]]
    }
    
    //Converts boolean into integer declaration (1 == true, 0 == false)
    private func scoreDataConverter(something:Bool) -> Int {
        var boolObj:Int
        if(something) {
            boolObj = 1
        } else {
            boolObj = 0
        }
        return boolObj
    }
    
    public func removeScoreData(teamNumber:Int) {
        let matches:[[Int]] = getMatches(teamNumber: teamNumber)
        var matchNumbersToRemove:[Int] = []
        for match in matches {
            matchNumbersToRemove += [match[12]]
        }
    }
    
    public func calculateAverage(teamNumber:Int) -> Double {
        var total = 0
        let matches = getMatches(teamNumber: teamNumber)
        for match in matches {
            total += varCheck(matchData: match[2], worth: 2)
            total += varCheck(matchData: match[3], worth: 10)
            total += varCheck(matchData: match[4], worth: 5)
            total += varCheck(matchData: match[5], worth: 10)
            total += varCheck(matchData: match[6], worth: 5)
            total += varCheck(matchData: match[7], worth: 2)
            total += varCheck(matchData: match[8], worth: 5)
            total += varCheck(matchData: match[9], worth: 5)
            total += varCheck(matchData: match[10], worth: 15)
        }
        return (Double(total)/Double(matches.count))
    }
    
    private func varCheck(matchData:Int, worth:Int) -> Int {
        if(matchData == 1) {
            return worth
        }
        return 0
    }
    
    public func setCurrentEvent(eventName:String) {
        EventName = eventName
        createFile()
    }
    
    private func createFile() {
        let text = ""
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(EventName+".txt")
            do {
                try text.write(to: path!,atomically: false, encoding:String.Encoding.utf8)
            }
            catch {}
        }
    }
    
    public func getMatchData(matchNumber:Int, teamNumber:Int) -> Array<Int> {
        var teamMatch:[Int] = []
        let matches: [[Int]] = getMatch(matchNumber: matchNumber)
        for match in matches {
            if(match[0] == teamNumber) {
                teamMatch = match
            }
        }
        return teamMatch
    }
    
    public func getMatch(matchNumber:Int) -> Array<Array<Int>> {
        var matches:[[Int]] = []
        for match in matchData {
            if(matchNumber == match[1]) {
                matches += [match]
            }
        }
        return matches
    }
    
    public func getMatches(teamNumber:Int) -> Array<Array<Int>> {
        var matches:[[Int]] = []
        for match in matchData {
            if(match[0] == teamNumber) {
                matches += [match]
            }
        }
        return matches
    }
    
    private func getTeams() -> Array<Int> {
        var teams:[Int] = []
        for match in matchData {
            teams += [match[0]]
        }
        return teams
    }
    
    //TODO: write data-saving method
    public func saveData() {
        
    }
    
    //TODO: write data-loading method
    public func loadData() {
        
    }
}

/*
 * Things stored in file:                           worth       Array location
 *  -Team Number                                                (0)
 *  -Match Number                                               (1)
 *  -Autonomous >> Reaching a defense            =  2 pts.      (2)
 *  -Autonomous >> Crossing a defense            = 10 pts.      (3)
 *  -Autonomous >> Boulder in a low tower goal   =  5 pts.      (4)
 *  -Autonomous >> Boulder in a high tower goal  = 10 pts.      (5)
 *  -Teleop >> Crossing a defense                =  5 pts.      (6)
 *  -Teleop >> Boulder in a low tower goal       =  2 pts.      (7)
 *  -Teleop >> Boulder in a high tower goal      =  5 pts.      (8)
 *  -Teleop >> Challenging the tower (per robot) =  5 pts.      (9)
 *  -Teleop >> Scaling the tower (per robot)     = 15 pts.      (10)
 *  -Foul  (5points to the other team)           =  0 pts.      (11)
 *  -Location in Array                                          (12)
 *
 */
