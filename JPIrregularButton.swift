//
//  IrregularButton.swift
//
//  Created by James Priestley on 26/09/2016.
//  Copyright © 2016 James Priestley. All rights reserved.
//

import UIKit

class IrregularButton: UIButton {

	
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		
		guard self.bounds.contains(point) else { return nil }
		
		var displayedImage: UIImage?
		if let img = self.image(for: self.state) {
			displayedImage = img
		} else if let img = self.backgroundImage(for: self.state) {
			displayedImage = img
		} else {
			return nil
		}
		
		
		if displayedImage!.isPointTransparent(point: point) {
			return nil
		}
		
		
		return self
		
	}

}
