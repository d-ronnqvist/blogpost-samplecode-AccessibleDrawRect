//
//  DRLogoView.m
//  AccessibleDrawRect
//
//  Created by David Rönnqvist on 3/5/13.
//  Copyright (c) 2013 David Rönnqvist. All rights reserved.
//

#import "DRLogoView.h"

@interface DRLogoView  ()
@property (copy) NSArray *elementsInLogo;

@property (strong) UIColor *brightColor;
@property (strong) UIColor *blueColor;

@end

@implementation DRLogoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _brightColor = [UIColor colorWithRed:0.946 green:0.945 blue:0.960 alpha:1.000];
        _blueColor = [UIColor colorWithRed:0.206 green:0.570 blue:0.872 alpha:1.000];
    }
    return self;
}

#pragma mark - Accessiblity Container protocol

- (BOOL)isAccessibilityElement {
    return NO;
}

- (NSInteger)accessibilityElementCount {
    return 2;
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
    return self.elementsInLogo[index];
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
    return [self.elementsInLogo indexOfObject:element];
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Create paths
    CGPathRef dPath = [self newPathForDShape];
    CGPathRef rPath = [self newPathForRShape];
    
    CGMutablePathRef bothPaths = CGPathCreateMutable();
    CGPathAddPath(bothPaths, NULL, dPath);
    CGPathAddPath(bothPaths, NULL, rPath);
    
    // Draw the paths in the center of the screen
    CGSize logoSize = CGPathGetBoundingBox(bothPaths).size;
    CGPathRelease(bothPaths);
    CGSize logoOffset = CGSizeMake(CGRectGetMidX(rect)-logoSize.width/2.0,
                                   CGRectGetMidY(rect)-logoSize.height/2.0);
    
    
    // Setup accessiblity elements
    UIAccessibilityElement *dElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    dElement.accessibilityLabel = @"D";
    dElement.accessibilityHint = @"The letter D in the DR logo.";
    dElement.accessibilityFrame = [self convertRect:CGRectOffset(CGPathGetBoundingBox(dPath), logoOffset.width, logoOffset.height)
                                             toView:nil];
    
    UIAccessibilityElement *rElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    rElement.accessibilityLabel = @"R";
    rElement.accessibilityHint = @"The letter R in the DR logo.";
    rElement.accessibilityFrame = [self convertRect:CGRectOffset(CGPathGetBoundingBox(rPath),logoOffset.width, logoOffset.height)
                                             toView:nil];
    
    self.elementsInLogo = @[dElement, rElement];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   self.brightColor.CGColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
    
    CGContextSetFillColorWithColor(context, 
                                   self.blueColor.CGColor);
    CGContextTranslateCTM(context, logoOffset.width, logoOffset.height);
    
    CGContextAddPath(context, dPath);
    CGContextAddPath(context, rPath);
    CGContextFillPath(context);
    
    // Release paths
    CGPathRelease(dPath);
    CGPathRelease(rPath);
}

#pragma mark - Shapes

- (CGPathRef)newPathForDShape {
    /*  
     M1,1 L1,44 L24,44 L24,24 L33,24 C33,24 46,23 56,32 C61,37 66,44 66,55 C66,66 61,73 57,77 C49,86 38,87 34,87 C29,87 24,87 24,87 L24,67 L1,67 L1,109 C1,109 21,109 35,109 C49,110 63,103 73,93 C84,83 89,69 89,55 C89,41 84,26 71,15 C58,3 44,1 35,1 Z */
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 1, 1);
    CGPathAddLineToPoint(path, NULL, 1, 44);
    CGPathAddLineToPoint(path, NULL, 24, 44);
    CGPathAddLineToPoint(path, NULL, 24, 24);
    CGPathAddLineToPoint(path, NULL, 33, 24);
    CGPathAddCurveToPoint(path, NULL, 33, 24, 46, 23, 56, 32);
    CGPathAddCurveToPoint(path, NULL, 61, 37, 66, 44, 66, 55);
    CGPathAddCurveToPoint(path, NULL, 66, 66, 61, 73, 57, 77);
    CGPathAddCurveToPoint(path, NULL, 49, 86, 38, 87, 34, 87);
    CGPathAddCurveToPoint(path, NULL, 29, 87, 24, 87, 24, 87);
    CGPathAddLineToPoint(path, NULL, 24, 67);
    CGPathAddLineToPoint(path, NULL, 1, 67);
    CGPathAddLineToPoint(path, NULL, 1, 109);
    CGPathAddCurveToPoint(path, NULL, 1, 109, 21, 109, 35, 109);
    CGPathAddCurveToPoint(path, NULL, 49, 110, 63, 103, 73, 93);
    CGPathAddCurveToPoint(path, NULL, 84, 83, 89, 69, 89, 55);
    CGPathAddCurveToPoint(path, NULL, 89, 41, 84, 26, 71, 15);
    CGPathAddCurveToPoint(path, NULL, 58, 3, 44, 1, 35, 1);
    CGPathAddLineToPoint(path, NULL, 24, 24);
    CGPathAddLineToPoint(path, NULL, 33, 24);
    CGPathAddCurveToPoint(path, NULL, 33, 24, 46, 23, 56, 32);
    CGPathAddCurveToPoint(path, NULL, 61, 37, 66, 44, 66, 55);
    CGPathAddCurveToPoint(path, NULL, 66, 66, 61, 73, 57, 77);
    CGPathAddCurveToPoint(path, NULL, 49, 86, 38, 87, 34, 87);
    CGPathAddCurveToPoint(path, NULL, 29, 87, 24, 87, 24, 87);
    CGPathAddLineToPoint(path, NULL, 24, 67);
    CGPathAddLineToPoint(path, NULL, 1, 67);
    CGPathAddLineToPoint(path, NULL, 1, 109);
    CGPathAddCurveToPoint(path, NULL, 1, 109, 21, 109, 35, 109);
    CGPathAddCurveToPoint(path, NULL, 49, 110, 63, 103, 73, 93);
    CGPathAddCurveToPoint(path, NULL, 84, 83, 89, 69, 89, 55);
    CGPathAddCurveToPoint(path, NULL, 89, 41, 84, 26, 71, 15);
    CGPathAddCurveToPoint(path, NULL, 58, 3, 44, 1, 35, 1);
    CGPathCloseSubpath(path);
    
    return path;
}

- (CGPathRef)newPathForRShape {
    /*
     M66,1 C66,1 81,8 90,24 C94,24 122,24 125,24 C128,24 134,25 138,31 C142,36 143,44 139,51 C135,57 128,59 125,59 C121,59 101,59 101,59 L152,122 L182,122 C182,122 147,78 145,76 C148,74 155,69 160,60 C165,51 166,42 164,32 C162,22 155,13 146,7 C137,1 130,1 126,1 C121,1 66,1 66,1 Z M66,1
     */
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 66, 1);
    CGPathAddCurveToPoint(path, NULL, 66,1, 81,8, 90,24);
    CGPathAddCurveToPoint(path, NULL, 94,24, 122,24, 125,24);
    CGPathAddCurveToPoint(path, NULL, 128,24, 134,25, 138,31);
    CGPathAddCurveToPoint(path, NULL, 142,36, 143,44, 139,51);
    CGPathAddCurveToPoint(path, NULL, 135,57, 128,59, 125,59);
    CGPathAddCurveToPoint(path, NULL, 121,59, 101,59, 101,59);
    CGPathAddLineToPoint(path, NULL, 152, 122);
    CGPathAddLineToPoint(path, NULL, 182, 122);
    CGPathAddCurveToPoint(path, NULL, 182,122, 147,78, 145,76);
    CGPathAddCurveToPoint(path, NULL, 148,74, 155,69, 160,60);
    CGPathAddCurveToPoint(path, NULL, 165,51, 166,42, 164,32);
    CGPathAddCurveToPoint(path, NULL, 162,22, 155,13, 146,7);
    CGPathAddCurveToPoint(path, NULL, 137,1, 130,1, 126,1);
    CGPathAddCurveToPoint(path, NULL, 121,1, 66,1, 66,1);
    CGPathCloseSubpath(path);

    return path;
}

@end
