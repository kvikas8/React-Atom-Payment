//
//  lib.h
//  WebView
//
//  Created by ATOM TECHNOLOGIES on 10/05/18.
//  Copyright (c) 2018 ATOM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Product.h"

#define statusTag 0
@protocol nbDelegate <NSObject>
-(void) secondviewcontrollerDissmissed:(NSString *)stringForFirst withResponseKeys:(NSMutableArray *)ResponseKeyArray andResponseValues:(NSMutableArray *)ResponseValueArray;

@end
  
  

@interface nb : UIViewController <UIWebViewDelegate,UIAlertViewDelegate,NSXMLParserDelegate>
{
    /*
    UIWebView *codeviewWeb;
    UIWebView *viewWeb;
    UIImageView *imageView;
  
    NSString *merchantId;
    NSString *txnscamt;
    NSString *loginid;
    NSString *password;
    NSString *prodid;
    NSString *txncurr;
    NSString *clientcode;
    NSString *custacc;
    
    NSString *amt;
    NSString *txnid;
    NSString *date;
    NSString *bankid;
    NSString *ru;
    
    NSString *signatureRequest;
    NSString *signatureResponse;
    NSString *discriminator;

    // Optional Parameters
    NSString *customerName;
    NSString *customerEmailID;
    NSString *customerMobileNo;
    NSString *billingAddress;
    NSString *optionalUdf9;
    UILabel *waitLabel;
*/
    Reachability* reachability;
}



@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
//@property (strong, nonatomic) IBOutlet UIWebView *codeviewWeb;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
//@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,retain)  UIImageView *imageView;
@property (nonatomic,retain)  UILabel *waitLabel;
@property (nonatomic,assign) id <nbDelegate> myDelegate;


@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *txnscamt;
@property (strong, nonatomic) NSString *loginid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *prodid;
@property (strong, nonatomic) NSString *txncurr;
@property (strong, nonatomic) NSString *clientcode;
@property (strong, nonatomic) NSString *custacc;
@property (strong, nonatomic) NSString *amt;
@property (strong, nonatomic) NSString *txnid;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *bankid;
@property (strong, nonatomic) NSString *ru;

@property (strong, nonatomic) NSString *signatureRequest;
@property (strong, nonatomic) NSString *signatureResponse;
@property (strong, nonatomic) NSString *discriminator;
//@property (strong, nonatomic) NSString *mprod;

@property (assign, nonatomic) bool isLive;

// Optional Parameters
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *customerEmailID;
@property (strong, nonatomic) NSString *customerMobileNo;
@property (strong, nonatomic) NSString *billingAddress;
@property (strong, nonatomic) NSString *optionalUdf9;
@property (strong, nonatomic) NSString *surcharge;
@property (strong, nonatomic) NSMutableArray<Product *> *mProds;

-(void)initialCall;
-(void)dismiss;
@end
