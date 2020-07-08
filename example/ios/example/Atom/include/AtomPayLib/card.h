//
//  card.h
//  WebView
//
//  Created by ATOM TECHNOLOGIES on 10/05/18.
//  Copyright (c) 2018 ATOM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Product.h"

#define statusTag 0
@protocol cardDelegate <NSObject>
-(void) secondviewcontrollerDissmissed:(NSString *)stringForFirst withResponseKeys:(NSMutableArray *)ResponseKeyArray andResponseValues:(NSMutableArray *)ResponseValueArray;

@end
  
  

@interface card : UIViewController <UITextFieldDelegate, UIWebViewDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    /*
   // UIWebView *codeviewWeb;
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
    NSString  *channelid;
    
    NSString *amt;
    NSString *txnid;
    NSString *date;
   
    NSString *cardData;
    NSString *cardNumber;
    NSString *cvv;
    NSString *expYear;
    NSString *expMonth;
    
    NSString *cardhname;
    NSString *cardtype;
    NSString *cardAssociate;
    
    NSString *mdd;
    NSString *ru;
    
    NSString *surcharge;
    NSString *signatureRequest;
    NSString *signatureResponse;

    // Optional Parameters
    NSString *customerName;
    NSString *customerEmailID;
    NSString *customerMobileNo;
    NSString *billingAddress;
    NSString *optionalUdf9;
    NSString *mprod;
    
    UIPickerView *yearPickerView;
    UIPickerView *monthPickerView;
   
    UIPickerView *pickerView;
    
    NSMutableArray *yeardataArray;
    NSMutableArray *monthdataArray;
    NSString *selectedCategory;
    
    NSString *navText;
     */
    
    Reachability* reachability;
}



@property (weak, nonatomic) IBOutlet UIImageView *imgBackGround;
@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
//@property (strong, nonatomic) IBOutlet UIWebView *codeviewWeb;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,retain)  UIImageView *imageView;
@property (nonatomic,assign) id <cardDelegate> myDelegate;


@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *txnscamt;
@property (strong, nonatomic) NSString *loginid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *prodid;
@property (strong, nonatomic) NSString *txncurr;
@property (strong, nonatomic) NSString *clientcode;
@property (strong, nonatomic) NSString *custacc;
@property (strong, nonatomic) NSString *channelid;

@property (strong, nonatomic) NSString *amt;
@property (strong, nonatomic) NSString *txnid;
@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSString *cardData;
@property (strong, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSString *cvv;
@property (strong, nonatomic) NSString *expYear;
@property (strong, nonatomic) NSString *expMonth;

@property (strong, nonatomic) NSString *cardhname;
@property (strong, nonatomic) NSString *cardtype;
@property (strong, nonatomic) NSString *cardAssociate;

// Optional Parameters
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *customerEmailID;
@property (strong, nonatomic) NSString *customerMobileNo;
@property (strong, nonatomic) NSString *billingAddress;
@property (strong, nonatomic) NSString *optionalUdf9;

@property (strong, nonatomic) NSString *mdd;
@property (strong, nonatomic) NSString *ru;

@property (strong, nonatomic) NSString *signatureRequest;
@property (strong, nonatomic) NSString *signatureResponse;
@property (strong, nonatomic) NSString *surcharge;
//@property (strong, nonatomic) NSString *mprod;
@property (strong, nonatomic) NSMutableArray<Product *> *mProds;

@property (assign, nonatomic) bool isLive;

@property (strong, nonatomic) NSString *navText;

- (IBAction)pay:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UITextField *cardEdhname;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhnumber;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhexpyr;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhexpmn;
@property (strong, nonatomic) IBOutlet UITextField *cardhEdCvv;
@property (strong, nonatomic) IBOutlet UIButton *pay;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (nonatomic, retain) UIPickerView *yearPickerView;
@property (nonatomic, retain) UIPickerView *monthPickerView;
@property (nonatomic, retain) NSMutableArray *yeardataArray;
@property (nonatomic, retain) NSMutableArray *monthdataArray;
@property (strong, nonatomic) NSString *selectedCategory;

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UILabel *labelAmt;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) IBOutlet UIView *middleView;
@property (nonatomic,retain)  UILabel *waitLabel;



-(void)dismiss;

-(void)cardinitialCall;





@end
