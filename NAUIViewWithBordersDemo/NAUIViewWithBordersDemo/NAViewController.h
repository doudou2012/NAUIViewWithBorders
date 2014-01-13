//
//  NAViewController.h
//  NAUIViewWithBordersDemo
//
//  Created by Nathan Rowe on 1/10/14.
//  Copyright (c) 2014 Natrosoft LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAUIViewWithBorders.h"

@interface NAViewController : UIViewController
{}
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *simpleExampleView;
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *differentBordersView;
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *differentDrawOrderView;
@property (nonatomic, weak) IBOutlet UILabel *differentDrawOrderLabel;
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *imageOverlayView;
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *bordersDrawnWithinLeftView;
@property (nonatomic, weak) IBOutlet NAUIViewWithBorders *bordersDrawnWithinRightView;


@end
