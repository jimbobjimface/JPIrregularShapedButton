//
//  UIColor+Transparency.swift
//
//  Created by James Priestley on 26/09/2016.
//  Copyright © 2016 James Priestley. All rights reserved.
//

import UIKit

extension UIImage {
	
	
	func isPointTransparent(point: CGPoint) -> Bool {
		
		let alpha = alphaAtPoint(point: point)
		return alpha < 0.01
	}
	
	
	
	func alphaAtPoint(point: CGPoint) -> CGFloat {
		
		
		guard CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height).contains(point) else { return 0 }
		
		
		let pointX = trunc(point.x)
		let pointY = trunc(point.y)
		
		let cgImage = self.cgImage
		
		let width = self.size.width
		let height = self.size.height
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bytesPerPixel:Int = 4
		let bytesPerRow:Int = bytesPerPixel * 1
		let bitsPerComponent:Int = 8
		
		let pixelData = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
		
		let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGImageByteOrderInfo.order32Big.rawValue
		
		if let context = CGContext(data: pixelData,
		                        width: 1,
		                        height: 1,
		                        bitsPerComponent: bitsPerComponent,
		                        bytesPerRow: bytesPerRow,
		                        space: colorSpace,
		                        bitmapInfo: bitmapInfo) {
		
			context.setBlendMode(CGBlendMode.copy)
			context.translateBy(x: -pointX, y: pointY - height)
			context.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
			
			let alpha = CGFloat(pixelData[3]) / 255
			return alpha
		
		}
		
		return 0
		
	}

}
