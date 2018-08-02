//
//  ViewController.swift
//  NumberAnimation
//
//  Created by dhara.patel on 09/05/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     let view1 = UIView()
     let view2 = UIView()
    
     let label1 = UILabel()
     let label2 = UILabel()
     let imageView1 = UIImageView()
     let imageView2 = UIImageView()
     let imageView3 = UIImageView()
     let imageView4 = UIImageView()
     let arrView = [UIView]()
    @IBOutlet weak var IBbtnReplay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        IBbtnReplay.backgroundColor = UIColor.yellow
        view1.frame = CGRect(x: self.view.frame.size.width - 60, y: 0, width: 60, height: 60)
        view1.layer.cornerRadius = view1.frame.size.width/2
        view1.tag = 1
        view1.backgroundColor = UIColor.red
        view1.clipsToBounds = true
        self.view.addSubview(view1)
        
        view2.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        view2.backgroundColor = UIColor.green
        view2.tag = 2
        view2.layer.cornerRadius = view2.frame.size.width/2
        view2.clipsToBounds = true
        self.view.addSubview(view2)
        
       
        
        let centerView = UIView()
        centerView.frame = CGRect(x: 0, y: self.view.frame.size.height/2 + 5 , width: self.view.frame.size.width, height: 10)
        centerView.backgroundColor = UIColor.yellow
        self.view.addSubview(centerView)
        
        label1.frame = CGRect(x: 0, y: 10, width: view1.frame.size.width, height: 40)
        label1.text = "\(2)"
        label1.font = UIFont(name: "helvetica neue", size: 30)
        label1.textAlignment = .center
        view1.addSubview(label1)
        
        label2.frame = CGRect(x: 0, y: 10, width: view2.frame.size.width, height: 40)
        label2.text = "\(3)"
        label2.font = UIFont(name: "helvetica neue", size: 30)
        label2.textAlignment = .center
        view2.addSubview(label2)
        
        imageView1.frame = CGRect(x: 0, y: self.view.frame.size.height/2 + 100, width: 40, height: 40)
        imageView1.image = UIImage(named: "fish2")
        view.addSubview(imageView1)
        
        imageView2.frame = CGRect(x: 0, y: self.view.frame.height/2 + 200, width: 40, height: 40)
        imageView2.image = UIImage(named: "fish1")
        view.addSubview(imageView2)
        
        imageView3.frame = CGRect(x: 0, y: self.view.frame.height/2 + 300, width: 40, height: 40)
        imageView3.image = UIImage(named: "fish4")
        view.addSubview(imageView3)

        imageView4.frame = CGRect(x: 0, y: self.view.frame.height/2 + 300, width: 40, height: 40)
        imageView4.image = UIImage(named: "fish2")
        view.addSubview(imageView4)
        //fish animate on bezierpath
        fishAnimation()
        
        //add gesture on view
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        panGestureRecognizer.minimumNumberOfTouches = 1
        view2.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        panGestureRecognizer1.minimumNumberOfTouches = 1
        view1.addGestureRecognizer(panGestureRecognizer1)
        
        //view animate and stop on centerview
        UIView.animate(withDuration: 2, delay: 1, options: .curveLinear, animations: {
            self.view1.frame = CGRect(x: 10, y: self.view.frame.size.height/2 + 5
                - 60, width: 60, height: 60)
            self.view2.frame = CGRect(x: self.view.frame.size.width - 10 - 60, y: self.view.frame.size.height/2 + 5 - 60, width: 60, height: 60)
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func panGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let tag = panGestureRecognizer.view?.tag
        if panGestureRecognizer.state == .began || panGestureRecognizer.state == .changed {
            let translation = panGestureRecognizer.translation(in: self.view)
            panGestureRecognizer.view!.center = CGPoint(x: panGestureRecognizer.view!.center.x + translation.x, y: panGestureRecognizer.view!.center.y + translation.y)
            panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }else if panGestureRecognizer.state == .ended{
            if tag == 1{
                respondToGesture(gesture: panGestureRecognizer,selectedview: view1, targetView: view2)
            }else{
                respondToGesture(gesture: panGestureRecognizer,selectedview: view2, targetView: view1)
            }
        }
    }
    //check location of anotherview
    func respondToGesture(gesture: UIGestureRecognizer,selectedview: UIView, targetView: UIView) {
        let tag = gesture.view?.tag
        //return boolean value - if location is match or not
        let touch = targetView.bounds.contains(gesture.location(in: targetView))
        if touch{
            UIView.animate(withDuration: 0.5, animations: {
                selectedview.isHidden = true
                targetView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
               
                let value1 = Int(self.label1.text!)
                let value2 = Int(self.label2.text!)
                if tag == 1{
                    self.label2.text = "\( value1! + value2!)"
                }else{
                    self.label1.text = "\( value1! + value2!)"
                }
            }, completion: { finish in
                UIView.animate(withDuration: 1.5, animations:{
                     targetView.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            })
        }else{
            //if location not match than it move on its current position
            UIView.animate(withDuration: 1, animations: {
                if tag == 1{
                    selectedview.frame = CGRect(x: 10, y: self.view.frame.size.height/2 + 5
                        - 60, width: 60, height: 60)
                }else{
                    selectedview.frame = CGRect(x: self.view.frame.size.width - 10 - 60, y: self.view.frame.size.height/2 + 5 - 60, width: 60, height: 60)
                }
            })
        }
    }
    func fishAnimation(){
        let path = FishBezierPath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.path = path.fishAnimatePath(polygonIn: view.bounds).cgPath
        self.view.layer.addSublayer(shapeLayer)
        
    UIView.animate(withDuration: 5, delay: 1, options: [.repeat, .autoreverse], animations: {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
        keyFrameAnimation.path =  path.fishAnimatePath(polygonIn: self.view.bounds).cgPath
        keyFrameAnimation.duration = 8
        keyFrameAnimation.fillMode = kCAFillModeForwards
        keyFrameAnimation.repeatCount = .infinity
        keyFrameAnimation.isRemovedOnCompletion = false
        self.imageView1.layer.add(keyFrameAnimation, forKey: "animation")
        self.imageView1.transform = CGAffineTransform.init(rotationAngle:  CGFloat(M_PI ))
       // UIView.animate(withDuration: 5, delay: 1, options: [.repeat, .autoreverse], animations: {
            keyFrameAnimation.duration = 10
            self.imageView2.layer.add(keyFrameAnimation, forKey: "fishanimation")
             self.imageView2.transform = CGAffineTransform.init(rotationAngle:  CGFloat(M_PI ))
            keyFrameAnimation.duration = 15
            self.imageView3.layer.add(keyFrameAnimation, forKey: "fishanimation")
            keyFrameAnimation.duration = 20 
            self.imageView4.layer.add(keyFrameAnimation, forKey: "fishanimation")
        //})
     })
    }
    @IBAction func btnClick(_ sender: Any) {
        view1.isHidden = false
        view2.isHidden = false
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

