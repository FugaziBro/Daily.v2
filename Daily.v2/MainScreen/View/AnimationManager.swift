//
//  AnimationManager.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 13.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class AnimationManager{

    public class CellAnimationManager{
        public func animateCell(cell: TableViewCell, withDelay: Double){
            if cell.isAnimated == true { return }
            let cellAppearanceAnimation = CASpringAnimation(keyPath: "transform.translation.x")
            cellAppearanceAnimation.fromValue = UIScreen.main.bounds.width
            cellAppearanceAnimation.duration = 0.5
            cellAppearanceAnimation.damping = 10
            cellAppearanceAnimation.beginTime = CACurrentMediaTime() + withDelay
            cellAppearanceAnimation.initialVelocity = 2
            cellAppearanceAnimation.stiffness = 90
            cell.layer.add(cellAppearanceAnimation, forKey: nil)
        }
        
    }
}
