//
//  FishBezierPath.swift
//  NumberAnimation
//
//  Created by dhara.patel on 10/05/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit

class FishBezierPath: UIBezierPath {

    func fishAnimatePath(polygonIn rect: CGRect) -> UIBezierPath {
       // self.init()
    let path = UIBezierPath()
    
    let width = rect.size.width
    let height = rect.size.height
    let upPoint:CGFloat = 50
    let onPoint:CGFloat = 100
    let downPoint:CGFloat = 150
    path.move(to: CGPoint(x: 20, y: height/2 + onPoint))
    path.addQuadCurve(to: CGPoint(x: width/3 , y: height/2 + onPoint), controlPoint: CGPoint(x: (width/3) / 2, y: height/2 + upPoint))
    path.addQuadCurve(to: CGPoint(x: (width - width/3), y: height/2 + onPoint), controlPoint: CGPoint(x: (width) / 2, y: height/2 + downPoint))
    path.addQuadCurve(to: CGPoint(x: width - 20, y: height/2 + onPoint), controlPoint: CGPoint(x: ((width + (width - width/3)) / 2), y: height/2 + upPoint))
    //add line right side
    path.addLine(to: CGPoint(x: width - 20, y: height/2 + 200))
    //for second path
    path.addQuadCurve(to: CGPoint(x: width - width/3, y: height/2 + 200), controlPoint: CGPoint(x: (width + (width - width/3)) / 2, y: height/2 + 250))
    path.addQuadCurve(to: CGPoint(x: width/3, y: height/2 + 200), controlPoint: CGPoint(x: width / 2, y: height/2 + 150))
    path.addQuadCurve(to: CGPoint(x: 20, y: height/2 + 200), controlPoint: CGPoint(x: (width/3) / 2, y: height/2 + 250))
    //add line left side
    path.addLine(to: CGPoint(x: 20, y: height / 2 + 100))
      return path
    }
}
