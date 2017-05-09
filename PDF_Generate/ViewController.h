//
//  ViewController.h
//  PDF_Generate
//
//  Created by Apple on 03/05/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPadding 20


@interface ViewController : UIViewController
{
    CGSize _pageSize;
}

- (IBAction)btnCreatePDFPress:(id)sender;

@end

