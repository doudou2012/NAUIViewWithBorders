//
//  NAViewController.m
//  NAUIViewWithBordersDemo
//
//  Created by Nathan Rowe on 1/10/14.
//  Copyright (c) 2014 Natrosoft LLC. All rights reserved.
//

#import "NAViewController.h"

@interface NAViewController ()
typedef void (^GCDSafeTimer)(void);
@property (nonatomic, copy) GCDSafeTimer safeTimer;
@end



#pragma mark -
@implementation NAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* Simple example with only a top border
     * - simply do not set the other border colors and they will not be drawn */
    self.simpleExampleView.borderColorTop   = [UIColor redColor];
    self.simpleExampleView.borderWidthsAll  = 1.0f;

    /* Example of each side of a view having different border colors and widths */
    self.differentBordersView.borderWidths      = UIEdgeInsetsMake(2.0, 4.0, 6.0, 8.0);
    self.differentBordersView.borderColorTop    = [UIColor blueColor];
    self.differentBordersView.borderColorRight  = [UIColor redColor];
    self.differentBordersView.borderColorBottom = [UIColor greenColor];
    self.differentBordersView.borderColorLeft   = [UIColor darkGrayColor];
    
    /* Example to illustrate how the draw order matters.  The default is clockwise
     * (top, right, bottom, left) as can be seen by how the lines overlap on the
     * corners with different colors.  The draw order can be changed. */
    self.differentDrawOrderView.borderWidthsAll     = 8.0;
    self.differentDrawOrderView.borderColorTop      = [UIColor blueColor];
    self.differentDrawOrderView.borderColorBottom   = [UIColor blueColor];
    self.differentDrawOrderView.borderColorLeft     = [UIColor greenColor];
    self.differentDrawOrderView.borderColorRight    = [UIColor greenColor];

    //Just set the draw order like so:
    self.differentDrawOrderView.drawOrder = [NSOrderedSet orderedSetWithObjects:kNABorderTop, kNABorderRight, kNABorderBottom, kNABorderLeft, nil];

    //Animation to illustrate what different draw orders look like
    [self startDrawOrderExampleAnimation];
    
    
    /* Example for drawing selective borders on image views.
     * NAUIImageWithBorders is a simple UIView subclass, so simply place it over top
     * of a UIImageView to simulate a UIImageView with selective borders. */
    self.imageOverlayView.borderWidthsAll = 2.0;
    self.imageOverlayView.borderColorRight = [UIColor blackColor];
    self.imageOverlayView.borderColorLeft = [UIColor blackColor];
    

    /* Example for knowing how to align borders.  Borders are drawn from the view's edge inward.
       They do not "spill" outside of its bounds */
    self.bordersDrawnWithinLeftView.borderWidthsAll = 3.0;
    self.bordersDrawnWithinLeftView.borderColorRight = [UIColor lightGrayColor];
    self.bordersDrawnWithinLeftView.borderColorBottom = [UIColor lightGrayColor];
    self.bordersDrawnWithinRightView.borderWidthsAll = 1.0;
    self.bordersDrawnWithinRightView.borderColorLeft = [UIColor blackColor];
    self.bordersDrawnWithinRightView.borderColorBottom = [UIColor blackColor];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//---------------------------
#pragma mark - Helper Methods
//---------------------------
- (void) startDrawOrderExampleAnimation
{
    //Create different draw orders
    NSOrderedSet *orderOne      = [NSOrderedSet orderedSetWithObjects:kNABorderTop, kNABorderRight, kNABorderBottom, kNABorderLeft, nil];
    NSString *orderOneLabel     = @"Clockwise draw order";
    self.differentDrawOrderLabel.text = orderOneLabel;
    NSOrderedSet *orderTwo      = [NSOrderedSet orderedSetWithObjects:kNABorderTop, kNABorderLeft, kNABorderBottom, kNABorderRight, nil];
    NSString *orderTwoLabel     = @"Counter-Clockwise draw order";
    NSOrderedSet *orderThree    = [NSOrderedSet orderedSetWithObjects:kNABorderTop, kNABorderBottom, kNABorderLeft, kNABorderRight, nil];
    NSString *orderThreeLabel   = @"Side borders drawn last";
    NSOrderedSet *orderFour     = [NSOrderedSet orderedSetWithObjects:kNABorderLeft, kNABorderRight, kNABorderTop, kNABorderBottom, nil];
    NSString *orderFourLabel    = @"Top & bottom borders drawn last";
    
    //Change draw order and force a redraw
    __weak id weakself = self;
    self.safeTimer = ^{
        double delaySeconds = 3.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            NAViewController *strongself = weakself;
            if (strongself)
            {
                //Cycle through different draw orders
                if (!strongself.differentDrawOrderView.drawOrder || [strongself.differentDrawOrderView.drawOrder isEqualToOrderedSet:orderFour]) {
                    strongself.differentDrawOrderView.drawOrder = orderOne;
                    strongself.differentDrawOrderLabel.text = orderOneLabel;
                }
                else if ([strongself.differentDrawOrderView.drawOrder isEqualToOrderedSet:orderOne]) {
                    strongself.differentDrawOrderView.drawOrder = orderTwo;
                    strongself.differentDrawOrderLabel.text = orderTwoLabel;
                }
                else if ([strongself.differentDrawOrderView.drawOrder isEqualToOrderedSet:orderTwo]) {
                    strongself.differentDrawOrderView.drawOrder = orderThree;
                    strongself.differentDrawOrderLabel.text = orderThreeLabel;
                }
                else if ([strongself.differentDrawOrderView.drawOrder isEqualToOrderedSet:orderThree]) {
                    strongself.differentDrawOrderView.drawOrder = orderFour;
                    strongself.differentDrawOrderLabel.text = orderFourLabel;
                }
                
                [strongself.differentDrawOrderView setNeedsDisplay];    /* redraw */
                
                //Run again
                strongself.safeTimer();
            }
        });
    };
    self.safeTimer();   //start running
}


@end
