//
//  ViewController.swift
//  coreGF
//
//  Created by Quan on 7/26/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var mainImageView: UIImageView!
    var lastPoint = CGPoint.zero
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var swiped = false
    var lineCap: CGLineCap! = CGLineCap.Round
    var baseImage = UIImage()
    let imgColors = ["black", "grey", "red", "blue", "lightblue", "darkgreen", "lightgreen", "brown", "darkorange", "yellow"]
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    @IBAction func reset(sender: AnyObject) {
        mainImageView.image = baseImage
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(mainImageView.image!, self, nil, nil)
    }
    
    @IBAction func album(sender: AnyObject) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate  = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickerImage: UIImage = (info[UIImagePickerControllerOriginalImage]) as! UIImage
        baseImage = pickerImage
        mainImageView.image = baseImage
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touches = touches.first {
            lastPoint = touches.locationInView(self.mainImageView)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touches = touches.first {
            let currentPoint = touches.locationInView(mainImageView)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !swiped {
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
    }
    
    @IBAction func btn_selectedSize(sender: AnyObject) {
        let index = sender.tag
        print("\(index)")
        switch index {
        case 0:
            lineCap = CGLineCap.Square
        case 1:
            lineCap = CGLineCap.Round
        case 2:
            lineCap = CGLineCap.Butt
        case 3:
            (red, green, blue) = colors[10]
        default:
            break
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, lineCap)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        CGContextStrokePath(context)
        
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainImageView.alpha = 1.0
        
        UIGraphicsEndImageContext()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count - 1
    }
    
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomizeCell", forIndexPath: indexPath) as! CustomizeCell
        cell.filteredImageView.image = UIImage(named: imgColors[indexPath.item])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        (red, green, blue) = colors[indexPath.item]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.brushWidth = CGFloat(Int(textField.text!)!)
        return true
    }
    
    

    


}

