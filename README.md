NAUIViewWithBorders
==================
UIView subclass that enables selective borders. (e.g. only a bottom border)
Each side can be figured with a different color and width.

Basic use case:
- Change your UIView in Interface Builder to class type NAUIViewWithBorders
- In your view controller's viewDidLoad
```
    /* For a top border ---------------------------------------------- */
    self.myBorderView.borderColorTop = [UIColor redColor];
    self.myBorderView..borderWidthsAll  = 1.0f;

    /* For borders with different colors and widths --------------------------- */
    self.myBorderView.borderWidths      = UIEdgeInsetsMake(2.0, 4.0, 6.0, 8.0);
    self.myBorderView.borderColorTop    = [UIColor blueColor];
    self.myBorderView.borderColorRight  = [UIColor redColor];
    self.myBorderView.borderColorBottom = [UIColor greenColor];
    self.myBorderView.borderColorLeft   = [UIColor darkGrayColor];

    /* For changing the draw order so that the top and bottom borders are draw on top like so ----------------------------
     *    ---------
     *    |       |
     *    ---------  
     */
    self.myBorderView.borderWidthsAll     = 8.0;
    self.myBorderView.borderColorTop      = [UIColor blueColor];
    self.myBorderView.borderColorBottom   = [UIColor blueColor];
    self.myBorderView.borderColorLeft     = [UIColor greenColor];
    self.myBorderView.borderColorRight    = [UIColor greenColor];
    self.myBorderView..drawOrder = [NSOrderedSet orderedSetWithObjects:kNABorderLeft, kNABorderRight,
                                                                       kNABorderTop, kNABorderBottom, nil];

    /* or with side borders drawn on top
     *    |---------|
     *    |         |
     *    |---------|
     */
    self.myBorderView..drawOrder = [NSOrderedSet orderedSetWithObjects:kNABorderTop, kNABorderBottom,
                                                                       kNABorderLeft, kNABorderRight, nil];
```


Notes:
- Borders are always drawn from the view's bounds inward. (border line will not spill outside view)
- Don't create a similar subclass to UIImageView (e.g. UIImageViewWithBorders) to get selective borders on a UIImageView.
  UIImageView does not call drawRect of its sublcasses, so the code to draw the selective borders will not run.  Place
  an NAUIViewWithBorders over top of a UIImageView to achieve selective borders.
- Be sure to check out the demo project.


 
![alt tag](http://natrosoft.com/wp-content/uploads/2014/01/oneBorder.png)   
    
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/1b4eef099ab4ddc7be7d89fc151c3dd8 "githalytics.com")](http://githalytics.com/natrosoft/NAUIViewWithBorders)
    
    
 