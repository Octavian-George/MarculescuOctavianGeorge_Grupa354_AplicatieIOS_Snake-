//
//  GameManager.swift
//  MarculescuOctavianGeorge_354_Snake
//
//  Created by user169232 on 5/5/20.
//  Copyright © 2020 Marculescu Octavian. All rights reserved.
//

import SpriteKit

class GameManager{
    var scene:GameScene!
    var nextTime: Double?
    var timeExtension: Double = 0.3
    //var timeExtension: Double = 1
    var playerDirection: Int = 1
    var eggDirection: Int = 1
    var currentScore: Int = 0

    init(scene:GameScene){
        self.scene=scene
    }
    
  
    
    //pozitia de start a sarpelui si a obstacolelor
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        scene.playerPositions.append((10, 13))
        
        scene.playerObstacles.append((5, 3))
        scene.playerObstacles.append((5, 4))
        scene.playerObstacles.append((5, 5))
        scene.playerObstacles.append((5, 6))
        scene.playerObstacles.append((5, 7))
        scene.playerObstacles.append((5, 8))
        scene.playerObstacles.append((5, 9))
        
        scene.playerObstacles.append((26, 8))
        scene.playerObstacles.append((26, 9))
        scene.playerObstacles.append((26, 10))
        scene.playerObstacles.append((26, 11))
        scene.playerObstacles.append((26, 12))
        scene.playerObstacles.append((26, 13))
        scene.playerObstacles.append((26, 14))
        scene.playerObstacles.append((26, 15))
        
        scene.playerObstacles.append((15, 19))
        scene.playerObstacles.append((15, 20))
        scene.playerObstacles.append((15, 21))
        scene.playerObstacles.append((15, 22))
        scene.playerObstacles.append((15, 23))
        scene.playerObstacles.append((15, 24))
        scene.playerObstacles.append((15, 25))
        scene.playerObstacles.append((15, 26))
        
        scene.playerObstacles.append((36, 3))
        scene.playerObstacles.append((36, 4))
        scene.playerObstacles.append((36, 5))
        scene.playerObstacles.append((36, 6))
        scene.playerObstacles.append((36, 7))
        scene.playerObstacles.append((36, 8))
        scene.playerObstacles.append((36, 9))
        scene.playerObstacles.append((36, 10))
        
        scene.eggPositions.append((7,20))
        
        renderChange()
        genereazaOua()
        genereazaOuaAlbastre()
    }
    
    //Verificarea coordonatelor
      func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
      let (c1, c2) = v
      for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
      return false
      }
    
    //Coloreaza sarpele,obstacolele si oualele dupa verificare
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x,y)) {
                node.fillColor = SKColor.red
            } else {
                node.fillColor = SKColor.clear
                if contains(a:scene.playerObstacles, v:(x,y)){
                    node.fillColor=SKColor.black
                }
                
                if contains(a:scene.eggPositions,v:(x,y)){
                    node.fillColor=SKColor.blue
                }
                if scene.gameScore != nil {
                    if Int((scene.gameScore?.x)!) == y && Int((scene.gameScore?.y)!) == x {
                        node.fillColor = SKColor.white
                    }
                }
            }
        }
    }
    
    
    
    //miscarea sarpelui
       private func actualizeazaLocatia() {
           //initializarea directiei de start
           var xChange = -1
           var yChange = 0
           //coordonatele de directie
           switch playerDirection {
                case 1:
                   //stanga
                   xChange = -1
                   yChange = 0
                   break
                case 2:
                   //sus
                   xChange = 0
                   yChange = -1
                   break
                case 3:
                   //dreapta
                   xChange = 1
                   yChange = 0
                   break
                case 4:
                   //jos
                   xChange = 0
                   yChange = 1
                   break
                case 0:
                   //cand moare
                   xChange = 0
                   yChange = 0
               default:
                   break
           }
           //deplasarea corpului sarpelui
           if scene.playerPositions.count > 0 {
               var start = scene.playerPositions.count - 1
               while start > 0 {
                   scene.playerPositions[start] = scene.playerPositions[start - 1]
                   start -= 1
               }
               scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
           }
        
        

           //teleportarea pentru sarpe
           if scene.playerPositions.count > 0 {
               let x = scene.playerPositions[0].1
               let y = scene.playerPositions[0].0
               if y > 41 {
                   scene.playerPositions[0].0 = 0
               } else if y < 0 {
                   scene.playerPositions[0].0 = 41
               } else if x > 27 {
                  scene.playerPositions[0].1 = 0
               } else if x < 0 {
                   scene.playerPositions[0].1 = 27
               }
           }
        //teleportarea pentru ouale albastre
        if scene.eggPositions.count > 0 {
            let x = scene.eggPositions[0].1
            let y = scene.eggPositions[0].0
            if y > 41 {
                scene.eggPositions[0].0 = 0
            } else if y < 0 {
                scene.eggPositions[0].0 = 41
            } else if x > 27 {
               scene.eggPositions[0].1 = 0
            } else if x < 0 {
                scene.eggPositions[0].1 = 27
            }
        }
           renderChange()
       }
    
    private func genereazaOua() {
        var randomX = CGFloat(arc4random_uniform(26))
        var randomY = CGFloat(arc4random_uniform(40))
        while contains(a: scene.playerPositions, v: (Int(randomX), Int(randomY))) {
            randomX = CGFloat(arc4random_uniform(26))
            randomY = CGFloat(arc4random_uniform(40))
        }
        scene.gameScore = CGPoint(x: randomX, y: randomY)
    }
    
    private func genereazaOuaAlbastre() {
        var randomX = CGFloat(arc4random_uniform(26))
        var randomY = CGFloat(arc4random_uniform(40))
        while contains(a: scene.eggPositions, v: (Int(randomX), Int(randomY))) {
            randomX = CGFloat(arc4random_uniform(26))
            randomY = CGFloat(arc4random_uniform(40))
        }
        scene.gameScore = CGPoint(x: randomX, y: randomY)
    }
    
    //deplasarea automata a oului albastru
    private func miscareOu(){
        //initializarea directiei de start
                  var xOu = -1
                  var yOu = 0
                  //coordonatele de directie
                  switch eggDirection {
                       case 1:
                          //stanga
                          xOu = -1
                          yOu = 0
                          break
                       case 2:
                          //sus
                          xOu = 0
                          yOu = -1
                          break
                       case 3:
                          //dreapta
                          xOu = 1
                          yOu = 0
                          break
                       case 4:
                          //jos
                          xOu = 0
                          yOu = 1
                          break
                      default:
                          break
                  }
        if scene.eggPositions.count > 0 {
            var start = scene.eggPositions.count - 1
            while start > 0 {
                scene.eggPositions[start] = scene.eggPositions[start - 1]
                start -= 1
            }
            scene.eggPositions[0] = (scene.eggPositions[0].0 + yOu, scene.eggPositions[0].1 + xOu)
        }
        renderChange()
    }
    
    //Actualizarea pozitiei sarpelui la deplasare
    func update (time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                actualizeazaLocatia()
                verificaPuncte()
                gameOver()
                incheiereJoc()
                miscareOu()
            }
        }
    }
    
       //deplasarea prin glisare
          func swipe(ID: Int) {
              if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
                  if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                      if playerDirection != 0 {
                          playerDirection = ID
                      }
                      
                  }
              }
          }
    
    //modifica punctajul la atingerea unui ou si creste dimensiunea sarpelui
    private func verificaPuncte() {
        if scene.gameScore != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            if Int((scene.gameScore?.x)!) == y && Int((scene.gameScore?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Puncte obtinute: \(currentScore)"
                genereazaOua()
                genereazaOuaAlbastre()
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
             }
         }
    }
      
       private func gameOver() {
           if scene.playerPositions.count > 0 {
               var arrayOfPositions = scene.playerPositions
               let headOfSnake = arrayOfPositions[0]
               arrayOfPositions.remove(at: 0)
               if contains(a: arrayOfPositions, v: headOfSnake) {
                   playerDirection = 0
               }
           }
       }
    
    private func actualizeazaPunctele() {
         if currentScore > UserDefaults.standard.integer(forKey: "bestScore") {
              UserDefaults.standard.set(currentScore, forKey: "bestScore")
         }
         currentScore = 0
         scene.currentScore.text = "Puncte obtinute: 0"
         scene.bestScore.text = "Cel mai mare punctaj obtinut: \(UserDefaults.standard.integer(forKey: "bestScore"))"
    }

    private func incheiereJoc() {
        if playerDirection == 0 && scene.playerPositions.count > 0 {
            var hasFinished = true
            let headOfSnake = scene.playerPositions[0]
            for position in scene.playerPositions {
                if headOfSnake != position {
                    hasFinished = false
                }
             }
         if hasFinished {
            print("Jocul s-a terminat! Felicitari pentru scorul obtinut!")
            actualizeazaPunctele()
            playerDirection = 1
            scene.gameScore = nil
            scene.playerPositions.removeAll()
            renderChange()
            //intoarcerea la pagina principala
            scene.currentScore.run(SKAction.scale(to: 0, duration: 0.4)) {
            self.scene.currentScore.isHidden = true
    }
            scene.gameBG.run(SKAction.scale(to: 0, duration: 0.4)) {
                self.scene.gameBG.isHidden = true
                self.scene.gameLogo.isHidden = false
                self.scene.gameLogo.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 200), duration: 0.5)) {
                     self.scene.playButton.isHidden = false
                     self.scene.playButton.run(SKAction.scale(to: 1, duration: 0.3))
                     self.scene.bestScore.run(SKAction.move(to: CGPoint(x: 0, y: self.scene.gameLogo.position.y - 50), duration: 0.3))
                   }
                self.scene.gameProgrammer.isHidden=false
                self.scene.gameProgrammer.run(SKAction.move(to: CGPoint(x: 0, y: (self.scene.frame.size.height / 2) - 150), duration: 0.5))
              }
              }
         }
    }
}
