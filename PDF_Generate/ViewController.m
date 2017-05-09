//
//  ViewController.m
//  PDF_Generate
//
//  Created by Apple on 03/05/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height
{
  _pageSize = CGSizeMake(width, height);
    NSString *newPDFName = [NSString stringWithFormat:@"%@.pdf", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:newPDFName];
    NSLog(@"%@",pdfPath);
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
    


}

- (void)beginPDFPage {
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, _pageSize.width, _pageSize.height), nil);
}



- (IBAction)btnCreatePDFPress:(id)sender {
    
    
     [self setupPDFDocumentNamed:@"NewPDF" Width:850 Height:1100];
    
    
    [self beginPDFPage];
    CGRect textRect = [self addText:@"USA is great Country"
                          withFrame:CGRectMake(kPadding, kPadding, 400, 200) fontSize:48.0f];
    
    CGRect textRect1 = [self addText:@"USA has power"
                          withFrame:CGRectMake(kPadding, 500, 400, 200) fontSize:48.0f];
    
    CGRect blueLineRect = [self addLineWithFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, _pageSize.width - kPadding*2, 4)
                                       withColor:[UIColor blueColor]];
    
    UIImage *anImage = [UIImage imageNamed:@"download.png"];
    CGRect imageRect = [self addImage:anImage
                              atPoint:CGPointMake((_pageSize.width/2)-(anImage.size.width/2), blueLineRect.origin.y + blueLineRect.size.height + kPadding)];
    
    [self addLineWithFrame:CGRectMake(kPadding, imageRect.origin.y + imageRect.size.height + kPadding, _pageSize.width - kPadding*2, 4)
                 withColor:[UIColor redColor]];
    
    [self finishPDF];
    
}


- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
    
    float textWidth = frame.size.width;
    
    if (textWidth < stringSize.width)
        textWidth = stringSize.width;
    if (textWidth > _pageSize.width)
        textWidth = _pageSize.width - frame.origin.x;
    
    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    return frame;

}

-   (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    // this is the thickness of the line
    CGContextSetLineWidth(currentContext, frame.size.height);
    
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    return  frame;

}

- (CGRect)addImage:(UIImage*)image atPoint:(CGPoint)point
{

    CGRect imageFrame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [image drawInRect:imageFrame];
    
    return imageFrame;
}

- (void)finishPDF {
    UIGraphicsEndPDFContext();
}



@end
