//
//  ViewController.swift
//  Treasure Hunt
//
//  Created by 陳佩琪 on 2023/6/8.
//

import UIKit

class ViewController: UIViewController {
    
    let playView = UIView()
    let backgroundImageView = UIImageView()
    let mapImageView = UIImageView()
    let tableView = UIView()
    let playerSlider = UISlider()
    //let playerImageVew = UIImageView()
    let treasureBoxImageView = UIImageView()
    let energyLabel = UILabel()
    let descriptionLabel = UILabel()
    let descriptionBackground = UIView()
    let statusBackground = UIView()
    let cushionImageView = UIImageView()
    let foundKey = UIImageView()
    
    let playerOnMap = UIImageView()
    let terminal = UIImageView()
    
    var cellArray: [UIImageView] = []
    var columnArray: [UIImageView] = []
    var mapElements: [Map] = []
    
    var energy = 16
    var getKey :Bool = false
    
    let endView = UIView()
    let endBackground = UIImageView()
    let finalResultView = UIImageView()
    let resultImage = UIImageView()
    let resultLabel = UILabel()
    let replayButton = UIButton()
    let playAgainButton = UIButton(type: .system)
    
    let menuView = UIView()
    let menuBackgroud = UIImageView()
    let instructionButton = UIButton(type: .system)
    let playButton = UIButton(type: .system)
    
    let instructionView = UIImageView()
    let nextButton = UIButton()
    var pageNo = 0

    fileprivate func generateMap() {
        //print("map elements:",mapElements.count)
        
        for i in 1...5 {
            for j in 1...5 {
                let cell = UIImageView()
                let cellWidth = tableView.frame.width/5
                let cellHeight = tableView.frame.height/5
                let cellX = 0 + cellWidth * ( CGFloat(j) - 1)
                let cellY = 0 + cellHeight * ( CGFloat(i) - 1)
                cell.frame = CGRect(x: cellX, y: 0 + cellY, width: cellWidth, height: cellHeight)
                cellArray.append(cell)
                tableView.addSubview(cell)
            }
        }
    }
    
    fileprivate func generateMapElements() {
        mapElements += [.startPoint]
        //var iconsArray: [Map] = Array(repeating: .lion, count: 1) + Array(repeating: .hills, count: 2) + Array(repeating: .swamp, count: 3) + Array(repeating: .forest, count: 4) + Array(repeating: .lake, count: 4) + Array(repeating: .cabin, count: 1) + [.key] + Array(repeating: .none, count: 7)
        Map.iconsArray.shuffle()
        mapElements += Map.iconsArray
        mapElements.append(.endPoint)
    }
    
    fileprivate func putPlayer() {
            playerOnMap.frame = CGRect(x: -15, y: -25.6, width: tableView.frame.width/5, height: tableView.frame.height/5)
            playerOnMap.image = UIImage(named: "player on map")
            tableView.addSubview(playerOnMap)
            //print(tableView.frame.origin,playerOnMap.frame.origin)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //background
        playView.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        backgroundImageView.frame = playView.bounds
        backgroundImageView.image = UIImage(named: "woodenBackground")
        
        cushionImageView.frame = CGRect(x: 20, y: 30, width: 97.5, height: 121.5)
        cushionImageView.image = UIImage(named: "cushion")
        foundKey.image = UIImage(named: "key")
        foundKey.frame = CGRect(x: 16, y: 12, width: 70, height: 91.2)
        foundKey.transform = CGAffineTransform(rotationAngle: .pi/180 * 20)
        foundKey.alpha = 0
        
        statusBackground.frame = CGRect(x: 124, y: 50, width: 250, height: 91)
        statusBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        statusBackground.layer.cornerRadius = 30
        statusBackground.clipsToBounds = true
        energyLabel.frame = CGRect(x: 6, y: 5, width: 250, height: 81)
        energyLabel.text = "⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️"
        energyLabel.font = UIFont.systemFont(ofSize: 26)
        energyLabel.numberOfLines = 0
        energyLabel.contentMode = .scaleToFill

        mapImageView.frame = CGRect(x: 0, y: 160, width: 390, height: 486)
        mapImageView.image = UIImage(named: "map")
        
        descriptionBackground.frame = CGRect(x: 20, y: 666, width: 350, height: 60)
        descriptionBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        descriptionBackground.layer.cornerRadius = 30
        descriptionBackground.clipsToBounds = true
        descriptionLabel.frame = CGRect(x: 10, y: 0, width: 330, height: 60)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.text = "拖動滑桿開始探險吧！"
        
        playerSlider.frame = CGRect(x: 30, y: 740, width: 260, height: 60)
        playerSlider.minimumTrackTintColor = UIColor.white
        playerSlider.maximumTrackTintColor = UIColor(white: 1, alpha: 0.3)
        playerSlider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        playerSlider.minimumValue = 0
        playerSlider.maximumValue = 24
        playerSlider.value = 0
        playerSlider.isContinuous = false
        playerSlider.addAction(UIAction(handler:  { [self, weak playerSlider] _ in
            playerMove(playerSlider!)
        }), for: .touchUpInside)
        
        
        
        //playerImageVew.frame = CGRect(x: 28, y: 730, width: 25.5, height: 60)
        //playerImageVew.image = UIImage(named: "player")
        treasureBoxImageView.frame = CGRect(x: 306, y: 740, width: 54, height: 54)
        treasureBoxImageView.image = UIImage(named: "treasure box")
        
        view.addSubview(playView)
        playView.addSubview(backgroundImageView)
        playView.addSubview(cushionImageView)
        cushionImageView.addSubview(foundKey)
        playView.addSubview(statusBackground)
        statusBackground.addSubview(energyLabel)
        playView.addSubview(mapImageView)
        playView.addSubview(playerSlider)
        playView.addSubview(descriptionBackground)
        descriptionBackground.addSubview(descriptionLabel)
        //playView.addSubview(playerImageVew)
        playView.addSubview(treasureBoxImageView)

        
        //map table
        tableView.frame = CGRect(x: 20, y: 20, width: 350, height: 456)
        mapImageView.addSubview(tableView)
        generateMapElements()
        generateMap()
        
        
        print("cell:",cellArray.count,"elements:",mapElements.count)
        
        
        terminal.frame = CGRect(x: tableView.frame.width/5 * 4 + 16, y: tableView.frame.height/5 * 4 + 16, width: tableView.frame.width/5, height: tableView.frame.width/5)
        //terminal.transform = CGAffineTransform(rotationAngle: .pi/180 * 5)
        terminal.image = UIImage(named: "flag")
        tableView.addSubview(terminal)
        
        putPlayer()
        
        endView.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        view.addSubview(endView)
        
        endBackground.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        endBackground.image = UIImage(named: "woodenBackground")
        endView.addSubview(endBackground)
        
        finalResultView.frame = CGRect(x: 5, y: 152, width: 380, height: 501)
        finalResultView.image = UIImage(named: "resultBackground")
        endView.addSubview(finalResultView)
        
        resultImage.frame = CGRect(x: 75, y: 81, width: 240, height: 240)
        resultImage.image = UIImage(named: "fail")
        //resultImage.image = UIImage(named: "success")
        finalResultView.addSubview(resultImage)
                
        resultLabel.frame = CGRect(x: 45, y: 336, width: 300, height: 60)
        //resultLabel.text = "好好休息，下次會更幸運！"
        //resultLabel.text = "太棒了，成功開啟寶箱！"
        resultLabel.numberOfLines = 0
        resultLabel.font = UIFont.boldSystemFont(ofSize: 18)
        resultLabel.textAlignment = .center
        finalResultView.addSubview(resultLabel)
        
        playAgainButton.frame = CGRect(x: 135, y: 700, width: 120, height: 50)
        playAgainButton.setTitle("返回首頁", for: .normal)
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        playAgainButton.tintColor = UIColor.white
        playAgainButton.addAction(UIAction(handler: { [self, weak playAgainButton] _ in
            replay(playAgainButton!)
        }), for: .touchUpInside)
        endView.addSubview(playAgainButton)
        
        endView.isHidden = true
        
        
        menuView.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        view.addSubview(menuView)
        
        menuBackgroud.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        menuBackgroud.image = UIImage(named: "woodenBackground")
        menuView.addSubview(menuBackgroud)
        
        playButton.frame = CGRect(x: 65, y: 450, width: 260, height: 260)
        playButton.setImage(UIImage(named: "rubber"), for: .normal)
        playButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        playButton.layer.cornerRadius = 20
        playButton.clipsToBounds = true
        playButton.addAction(UIAction(handler: {[self, weak playButton] _ in
            play(playButton!)
        }), for: .touchUpInside)
        menuView.addSubview(playButton)
        
        instructionButton.frame = CGRect(x: 65, y: 130, width: 260, height: 260)
        instructionButton.setImage(UIImage(named: "instruction"), for: .normal)
        instructionButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        instructionButton.layer.cornerRadius = 20
        instructionButton.clipsToBounds = true
        instructionButton.addAction(UIAction(handler: {[self] _ in
            print("clicked")
            instructionView.isHidden = false
            nextButton.isHidden = false
            pageNo = 1
            instructionView.image = UIImage(named: String(pageNo))
            print(pageNo)
        }), for: .touchUpInside)
        menuView.addSubview(instructionButton)
        
        
        
        instructionView.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        view.addSubview(instructionView)
        instructionView.image = UIImage(named: "1")
        instructionView.isHidden = true
        nextButton.frame = instructionView.frame
        nextButton.setTitle("", for: .normal)
        nextButton.backgroundColor = UIColor.clear
        nextButton.addAction(UIAction(handler: {[self] _ in
            pageNo = (pageNo + 1) % 4
            if pageNo != 0 {
                instructionView.image = UIImage(named: String(pageNo))
            } else {
                instructionView.isHidden = true
                nextButton.isHidden = true
            }
            print(pageNo)
        }), for: .touchUpInside)
        menuView.addSubview(nextButton)
        nextButton.isHidden = true
    }


    @objc func playerMove(_ sender: UISlider) {
        //print(playerOnMap.frame.origin)
        
        let index = Int(sender.value.rounded())
        
        cellArray[index].image = UIImage(named: mapElements[index].imageName)
        
        let cellX = cellArray[index].frame.minX
        let cellY = cellArray[index].frame.minY
        let playerX = playerOnMap.center.x
        let playerY = playerOnMap.center.y
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [self] in
            self.playerOnMap.transform = CGAffineTransform(translationX: cellX-playerX + 16 , y: cellY-playerY + 16)
        }, completion: nil)


        
        descriptionLabel.text = mapElements[index].description
        descriptionLabel.numberOfLines = 0
        energy += mapElements[index].energyChange
        
        var energyString = ""
        
        if energy >= 16 {
            energy = 16
        }
        if energy > 0 {
            for _ in 1 ... energy {
                energyString += "⚡️"
            }
        } else {
            energyString = ""
        }
        energyLabel.text = energyString
        
        //print(energy)
        

        
        if mapElements[index] == .key {
            getKey = true
            tableView.clipsToBounds = false
            
            let moveX = cushionImageView.frame.minX - (tableView.frame.minX + cellArray[index].frame.minX)
            let moveY = cushionImageView.frame.minY - (tableView.frame.minY + mapImageView.frame.minY + cellArray[index].frame.minY)
            //print("cusion:",cushionImageView.frame.minX,cushionImageView.frame.minY,"table:",tableView.frame.minX,tableView.frame.minY,"keyCell:",cellArray[index].frame.minX,cellArray[index].frame.minY,"move:",moveX,moveY)
            
            UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut, animations: { [self] in
                self.cellArray[index].transform = CGAffineTransform(translationX: moveX + 16, y: moveY + 12).rotated(by: .pi/180 * 20)
            }, completion: nil)
            //print("after:",cellArray[index].frame.minX,cellArray[index].frame.minY)
           
            UIView.animate(withDuration: 0.01, delay: 1.5, options: .curveEaseInOut, animations: { [self] in
                self.foundKey.alpha = 1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.01, delay: 1.5, options: .curveEaseInOut, animations: { [self] in
                self.cellArray[index].alpha = 0
                self.cellArray[index].transform = CGAffineTransform(translationX: 0, y: 0).rotated(by: .pi/180 * 0)
            }, completion: nil)
            mapElements[index] = .none

        }
        
        
        if index == 24 {
            switch getKey {
            case true:
                endView.isHidden = false
                resultImage.image = UIImage(named: "success")
                resultLabel.text = "太棒了，成功開啟寶箱！"
            default:
                descriptionLabel.text = "還沒找到鑰匙，無法開啟寶箱。"
            }
        } else {
            if energy <= 0 {
            endView.isHidden = false
                switch getKey {
                case true:
                    resultImage.image = UIImage(named: "fail")
                    resultLabel.text = "差一點點就能開啟寶箱了。\n下次再試試吧！"
                default:
                    resultImage.image = UIImage(named: "fail")
                    resultLabel.text = "好好休息，下次會更幸運！"
                }
            }
        }
        
        
        //print(index)

    }
    
    
    
    @objc func play(_ sender: UIButton) {
    
        endView.isHidden = true
        
        energy = 16
        playerSlider.value = 0
        energyLabel.text = "⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️"
        getKey = false
        foundKey.alpha = 0
        descriptionLabel.text = "拖動滑桿開始探險吧！"
        descriptionLabel.numberOfLines = 0
        
        for cell in cellArray {
            cell.removeFromSuperview()
        }
        playerOnMap.removeFromSuperview()
        cellArray.removeAll()
        mapElements.removeAll()

        generateMapElements()
        generateMap()
        
        
        putPlayer()
        playerOnMap.frame = CGRect(x: -15, y: -25.6, width: tableView.frame.width/5, height: tableView.frame.height/5)
        
        menuView.isHidden = true
        
    }
    
    @objc func replay(_ sender: UIButton) {
        menuView.isHidden = false
    }
    
    
}

