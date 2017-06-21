//
//  ViewController.swift
//  Canvas
//
//  Created by phil_nachum on 8/17/16.
//  Copyright © 2016 phil_nachum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayOpenCenter: CGPoint!
    var trayClosedCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var faceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        trayOpenCenter = trayView.center
        trayClosedCenter = CGPoint(
            x: trayOpenCenter.x,
            y: view.frame.height + (trayView.frame.height / 2) - 50
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayGesture(sender: UIPanGestureRecognizer) {
        
        let point = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = sender.view!.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(
                x: trayOriginalCenter.x,
                y: trayOriginalCenter.y + translation.y
            )
        } else if sender.state == UIGestureRecognizerState.Ended {
            print(point)
            UIView.animateWithDuration(0.2, animations: {
                if velocity.y > 0 {
                    self.trayView.center = self.trayClosedCenter
                } else {
                    self.trayView.center = self.trayOpenCenter
                }
            })
        }

    }

    @IBAction func onFaceGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            let faceCenter = sender.view!.center
            faceOriginalCenter = CGPoint(
                x: faceCenter.x + trayView.frame.origin.x,
                y: faceCenter.y + trayView.frame.origin.y
            )
            
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(
                x: faceOriginalCenter.x + translation.x,
                y: faceOriginalCenter.y + translation.y
            )
        } else if sender.state == UIGestureRecognizerState.Ended {

        }
        
    }
}

