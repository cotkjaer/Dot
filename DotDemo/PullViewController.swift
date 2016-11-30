//
//  PullViewController.swift
//  Dot
//
//  Created by Christian Otkjær on 30/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

class PullViewController: UIViewController
{
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    func squareIt()
    {
        let bounds = view.bounds
        
        let side = min(bounds.width, bounds.height) - 20
        
        let h = (bounds.height - side) / 2
        
        top.constant = h
        bottom.constant = h
        
        let w = (bounds.width - side) / 2
        
        leading.constant = w
        trailing.constant = w
    }
    
    @IBOutlet weak var dot: Dot?
    
    let margin : CGFloat = 40
    
    var indicatorDot : Dot?
    
    var activeHorizontalConstraint : NSLayoutConstraint?
    
    var activeVerticalConstraint : NSLayoutConstraint?
    
    @IBAction func handlePan(_ pan: UIPanGestureRecognizer)
    {
        let location = pan.location(in: view)
        
        guard let dotFrame = dot?.frame else { return }
        
        switch pan.state
        {
        case .began:
            
            guard dotFrame.contains(location) == true else { return }
            
            if location.x > dotFrame.maxX - margin
            {
                activeHorizontalConstraint = trailing
            }
            else if location.x < dotFrame.minX + margin
            {
                activeHorizontalConstraint = leading
            }
            else
            {
                activeHorizontalConstraint = nil
            }
            
            
            if location.y > dotFrame.maxY - margin
            {
                activeVerticalConstraint = bottom
            }
            else if location.y < dotFrame.minY + margin
            {
                activeVerticalConstraint = top
            }
            else
            {
                activeVerticalConstraint = nil
            }
            
            indicatorDot = Dot(frame: CGRect(center: location, size: CGSize(width: 40, height: 40)))
            
            indicatorDot?.fillColor = .orange
            view.addSubview(indicatorDot!)
            
            fallthrough
            
        case .changed:
            
            guard activeVerticalConstraint != nil || activeHorizontalConstraint != nil else { return }
            
            activeHorizontalConstraint?.constant += pan.translation(in: view).x
            activeVerticalConstraint?.constant += pan.translation(in: view).y

            view.setNeedsLayout()
            
            pan.setTranslation(.zero, in: view)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorDot?.center = location
                self.view.layoutIfNeeded()
            })
            
        default:
            
            activeHorizontalConstraint = nil
            activeVerticalConstraint = nil
            
            guard let indicatorDot = indicatorDot else { return }
            
            self.indicatorDot = nil
            
            UIView.transition(
                with: indicatorDot,
                duration: 0.5,
                options: [.beginFromCurrentState],
                animations: { 
                    indicatorDot.alpha = 0
            },
                completion: { _ in
                    
                indicatorDot.removeFromSuperview()
            })
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
