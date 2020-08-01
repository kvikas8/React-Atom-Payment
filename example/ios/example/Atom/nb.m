
#import "nb.h"
#import "Reachability.h"
#import <CommonCrypto/CommonHMAC.h>
#import "WKWebView+FLWKWebView.h"
#import "ObjC/Runtime.h"

@interface nb ()<WKUIDelegate,WKNavigationDelegate>
{
    NSXMLParser *parser;
    NSString *element;
    
    NSDictionary *myAttrDict;
    NSString *attributesNames;
    NSString *attributesNamesId;
    NSMutableArray *names;
    
    NSMutableArray *formParam;
    NSMutableArray *formUrl;
    NSString *result;
    NSMutableArray *resultFromCallback;

    
}
@end

NSString *global_url = @"";

@implementation nb
@synthesize activityIndicator,viewWeb,imageView,codeviewWeb,myDelegate,
merchantId,txnscamt,loginid,password,prodid,txncurr,clientcode,custacc,amt,txnid,date,bankid,ru,waitLabel,reqHashKey,resHashKey;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [activityIndicator startAnimating];
    
  

    
    /* float h =self.view.bounds.size.height;
     if(h > 480)
     {
     activityIndicator.frame = CGRectMake(115,217,100,100);
     viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, 568)];
     }else
     {
     activityIndicator.frame = CGRectMake(125,208,80,40);
     viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
     }
     */
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    
    
    float h =self.view.bounds.size.height;
    float w = self.view.bounds.size.width;
    if(h > 480)
    {
        activityIndicator.frame = CGRectMake(w/2-50,h/2-100,100,100);
        viewWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, w, h-64)configuration:configuration];
    }else
    {
        activityIndicator.frame = CGRectMake(w/2-50,h/2-100,80,40);
        viewWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, w, h-64)configuration:configuration];
    }
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, w, 64.0f)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    
    
    // UIButton *cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    // [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    // [cancelButton setFrame:CGRectMake(w-80, 12.0f, 72.0f, 48.0f)];
    // [cancelButton addTarget:self action:@selector(cancelNav:) forControlEvents:UIControlEventTouchUpInside];
    
    // [topView addSubview:cancelButton];
    
    
    [self.view addSubview:topView];
    
    
  //  viewWeb.scrollView.scrollEnabled = TRUE;
    
    [self.viewWeb addSubview:activityIndicator];
    
    //CGFloat labelX = activityIndicator.bounds.size.width + 2;
    
    waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(w/2-100, h/2-100, 200, 50)];
    waitLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    waitLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    waitLabel.numberOfLines = 2;

    waitLabel.backgroundColor = [UIColor clearColor];
    waitLabel.textColor = [UIColor blackColor];
    waitLabel.text = @"Please wait, while we processing your request..";

    [self.viewWeb addSubview:waitLabel];
    
    UIImage *image = [UIImage imageNamed:@"atom-logo.png"];
    
    imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(ceil(CGRectGetWidth(viewWeb.frame) - 140), h-144, 126, 66)];
    
    imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    // WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    // [theConfiguration.userContentController addScriptMessageHandler:self name:@"cancel"];
    // viewWeb = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
                      

    
    // [imageView addSubview:activityIndicator];
    [[self viewWeb] setDelegateViews: self];


    [self.viewWeb addSubview:imageView];
    [self.view  addSubview:viewWeb];
    [self initialCall];
    // [imageView addSubview:label];
    
   //[viewWeb setDelegate:self];
    // [activityIndicator stopAnimating];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
     NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    
    
   
    
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
    
    //       Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //       NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //        if (networkStatus == NotReachable) {
    //          //  NSLog(@"NO internet connection");
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Not Available"
    //                                                            message:@"Please check the Network connectivity "
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"OK"
    //                                                  otherButtonTitles: nil];
    //            [alert show];
    //
    //        } else {
    
    
    //   }
    
}

-(void)initialCall
{
   // ru = @"https://payment.atomtech.in/mobilesdk/param";
     ru = @"https://paynetzuat.atomtech.in/mobilesdk/param";
    
//   NSString *urlstring= [NSString stringWithFormat:@"https://paynetzuat.atomtech.in/paynetz/epi/fts?login=%@&pass=%@&ttype=NBFundTransfer&prodid=%@&amt=%@&txncurr=%@&txnscamt=%@&clientcode=%@&txnid=%@&date=%@&custacc=%@&ru=https://paynetzuat.atomtech.in/paynetz/param",loginid,password,prodid,amt,txncurr,txnscamt,clientcode,txnid,date,custacc];

    
     NSString *urlstring = [NSString stringWithFormat:@"https://paynetzuat.atomtech.in/paynetz/epi/fts?login=%@&pass=%@&ttype=NBFundTransfer&prodid=%@&amt=%@&txncurr=%@&txnscamt=%@&clientcode=%@&txnid=%@&date=%@&custacc=%@&ru=%@",loginid,password,prodid,amt,txncurr,txnscamt,clientcode,txnid,date,custacc,ru];
   
    if(udf1 != NULL && [udf1 isEqualToString:@""]){
        urlstring = [NSString stringWithFormat:@"%@&udf1=%@",urlstring,udf1];
    }
    
    if(udf2 != NULL && [udf2 isEqualToString:@""]){
        urlstring = [NSString stringWithFormat:@"%@&udf2=%@",urlstring,udf2];
    }
    
    if(udf3 != NULL && [udf3 isEqualToString:@""]){
        urlstring = [NSString stringWithFormat:@"%@&udf3=%@",urlstring,udf3];
    }
    
    if(udf4 != NULL && [udf4 isEqualToString:@""]){
        urlstring = [NSString stringWithFormat:@"%@&udf4=%@",urlstring,udf4];
    }

    if(udf5 != NULL && [udf5 isEqualToString:@""]){
        urlstring = [NSString stringWithFormat:@"%@&udf5=%@",urlstring,udf5];
    }
//     NSString *urlstring= [NSString stringWithFormat:@"https://payment.atomtech.in/paynetz/epi/fts?login=%@&pass=%@&ttype=NBFundTransfer&prodid=%@&amt=%@&txncurr=%@&txnscamt=%@&clientcode=%@&txnid=%@&date=%@&custacc=%@&ru=%@",loginid,password,prodid,amt,txncurr,txnscamt,clientcode,txnid,date,custacc,ru];
    
    if(bankid != NULL && !([bankid isEqualToString:@""]) && !([bankid isEqualToString:@"0"])){
        urlstring = [NSString stringWithFormat:@"%@&bankid=%@",urlstring,bankid];
    }
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",loginid,password,@"NBFundTransfer",prodid,txnid,amt,@"INR"];
    
    NSString *signature = [self hmacSHA512:str withKey:reqHashKey];
    urlstring = [NSString stringWithFormat:@"%@&signature=%@",urlstring,signature];
    
    urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"Received Url------>%@",urlstring);
    
    //    NSURL *url = [NSURL URLWithString:urlstring];
    //    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    //3ef6485efe1d2eafaae59357ac94a59646b0b5f9039a61bbc823420ef76e6c99139d59cb637127c7bedde3a8de7b3da88c1ae09f0b993831a15bf975e7a33310
    
    //704e6a78ca61c89127ca5430ddf59a329dacb142ae2790e19d676f5ca8ca80b9c534552e877bfb0ce1c2dddf252ae3d7580d329556213811f828711e9f4ea371  //working key
    
    
    NSError *error;
    NSURL *url = [NSURL URLWithString:urlstring];
    NSLog(@"URL----->%@",urlstring);
    
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
//    self.viewWeb.scrollView.bounces =NO;
    [self.viewWeb loadRequest:requestObj];
    
    /*
    NSString *dataString =[[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error] ;
    
    NSData *data  = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];*/
    
    
}
/*
-(void)webViewDidStartLoad:(WKWebView *)webView
{
    NSLog(@"web view did start load");

    //[self.viewWeb addSubview:activityIndicator];
    // [self.viewWeb addSubview:waitLabel];
    
    //    [activityIndicator startAnimating];
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
    
}
 */

- (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation
{
    
    [self didStartNavigation];
}
/*
 * This is called whenever the web view has started navigating.
*/
- (void) didStartNavigation
{
     NSLog(@"web view  didStartNavigation...");
    // Update things like loading indicators here.
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
}

/*
-(BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"web view  should start load....");
    NSLog(@"Loading: %@", [request URL]);
  
   
    if([request URL] != nil && ![[request URL] isEqual:@""]){
        return YES;
    } else {
        return NO;
    }
}
*/


- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction *) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    decisionHandler([self shouldStartDecidePolicy: [navigationAction request]]);
}

- (BOOL) shouldStartDecidePolicy: (NSURLRequest *) request
{
    // Determine whether or not navigation should be allowed.
    // Return YES if it should, NO if not.
    
    NSLog(@"web view  should start load....");
      NSLog(@"Loading: %@", [request URL]);
    
    global_url = [request URL].absoluteString;
    
      if([request URL] != nil && ![[request URL] isEqual:@""]){
          return YES;
      } else {
          return NO;
      }
}

- (void) webView: (WKWebView *) webView didFinishNavigation: (WKNavigation *) navigation
{
    NSLog(@"****didFinish Again: %@; ****stillLoading: %@", [[webView request]URL],
    (webView.loading?@"YES":@"NO"));
    NSLog(@"Globally Set URL: %@", global_url);

   //  [self.viewWeb stringByEvaluatingJavaScriptFromString:@"var div = document.createElement('div');div.innerHTML='<a href=\'https://www.atomtech.in/\' style= \'display: none;\'  ></a>';document.getElementsByTagName('body')[0].appendChild(div);"];
    
    // [self.viewWeb evaluateJavaScript:@"var div = document.createElement('div');div.innerHTML='<a href=\'https://www.atomtech.in/\' style= \'display: none;\'  ></a>';document.getElementsByTagName('body')[0].appendChild(div);" completionHandler:^(id result, NSError *error) {
    //              if (error == nil)
    //              {
    //                  if (result != nil)
    //                  {
    //                      NSInteger integerResult = [result integerValue]; // 2
    //                      NSLog(@"result: %d", integerResult);
    //                  }
    //              }
    //              else
    //              {
    //                  NSLog(@"evaluateJavaScript error : %@", error.localizedDescription);
    //              }
                  NSLog(@"=========== COMPLETED ORIGINAL =========== with result");
        // NSLog(@"Path Original: %@", viewWeb.request.URL.absoluteString);
          //    }];
               
    
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
    NSLog(@"Absolute URL: %@", viewWeb.request.URL.absoluteURL);
    
    NSString *currentURL = viewWeb.request.URL.absoluteString;
       
       if([currentURL rangeOfString:@"atomtech.in"].location != NSNotFound)
       {
           imageView.hidden = YES;
       } else {
           imageView.hidden = NO;
       }
       NSLog(@"weurl---->%@",currentURL);
    
    // if([currentURL hasSuffix:@"/mobilesdk/param"])
    if(global_url != nil && ![global_url isEqual:@""] && [global_url hasSuffix:@"/mobilesdk/param"])
    // if([currentURL hasSuffix:@"/mobilesdk/param"])
       {
         //  NSString *htmlSource = [self.viewWeb stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
           
          [self.viewWeb evaluateJavaScript:@"document.documentElement.outerHTML" completionHandler:^(NSString *result, NSError *error) {
              if (error == nil)
              {
                  if (result != nil)
                  {
                      if(result!= nil && [result rangeOfString:@"success_00" options:NSCaseInsensitiveSearch].location != NSNotFound)
                      {
                          result=[self convertHTMLTableString:result];
                          resultFromCallback = [self convertOutputToArray:result];
                          NSLog(@"Result transaction successful %@",result);

                      }
                      else if(result != nil)
                      {
                           result = [self convertHTMLTableString:result];
                           resultFromCallback = [self convertOutputToArray:result];
                           NSLog(@"Transaction Failed!");
                      }
                      [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
                  }
              }
              else
              {
                  NSLog(@"evaluateJavaScript error : %@", error.localizedDescription);
                 [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
              }
          }];
           
          /*
           NSLog(@"html---->%@",htmlSource);
           
           if(htmlSource!= nil && [htmlSource rangeOfString:@"success_00" options:NSCaseInsensitiveSearch].location != NSNotFound)
           {
               result=[self convertHTMLTableString:htmlSource];
               
               NSLog(@"Result transaction successful %@",result);

           }
           else if(htmlSource != nil)
           {
               result = [self convertHTMLTableString:htmlSource];
                NSLog(@"Transaction Failed!");
           }
           [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
           */
       }
    
    
    
    
    //[self finishLoadOrNavigation: [webView request]];
}

/*
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     NSLog(@"web view did finish load");
 
   
    
    NSLog(@"****didFinish: %@; ****stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
    
    [self.viewWeb stringByEvaluatingJavaScriptFromString:@"var div = document.createElement('div');div.innerHTML='<a href=\'https://www.atomtech.in/\' style= \'display: none;\'  ></a>';document.getElementsByTagName('body')[0].appendChild(div);"];
    
    
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
    
    
    NSString *currentURL = viewWeb.request.URL.absoluteString;
    
    if([currentURL rangeOfString:@"atomtech.in"].location != NSNotFound)
    {
        imageView.hidden = YES;
    } else {
        imageView.hidden = NO;
    }
    NSLog(@"weurl---->%@",currentURL);
    
    
    
    if([currentURL hasSuffix:@"/mobilesdk/param"])
    {
        NSString *htmlSource = [self.viewWeb stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        NSLog(@"html---->%@",htmlSource);
        
        if(htmlSource!= nil && [htmlSource rangeOfString:@"success_00" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            result=[self convertHTMLTableString:htmlSource];
            
            NSLog(@"Result transaction successful %@",result);

        }
        else if(htmlSource != nil)
        {
            result = [self convertHTMLTableString:htmlSource];
             NSLog(@"Transaction Failed!");
        }
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
    }
   
    
}

*/


/*
- (void)webView:(WKWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFail: %@; stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
}*/

/*
 * Called on iOS devices that have WKWebView when the web view fails to load a URL request.
 * Note that it just calls failLoadOrNavigation, which is a shared delegate method.
 */
- (void) webView: (WKWebView *) webView didFailNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    NSLog(@"didFail: %@; stillLoading: %@", [[webView request]URL],
    (webView.loading?@"YES":@"NO"));
   // [self failLoadOrNavigation: [webView request] withError: error];
}


-(void)dismiss
{
    NSLog(@"I am being dismissed");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myDelegate secondviewcontrollerDissmissed:resultFromCallback];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
//- (void)alertView:(UIAler *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    if (buttonIndex == alert.cancelButtonIndex) {
//        [self viewDidAppear:YES];
//    }
//}




-(NSString *)convertHTMLTableString:(NSString *)htmlString{
    
    /* if(htmlString != nil){
     //    NSString *formattedStr;
     htmlString=[self removeHeaderTag:htmlString];
     htmlString=[self validateTableRow:htmlString];
     htmlString=[self validateTableData:htmlString];
     htmlString=[self removeHeaderEnd:htmlString];
     
     
     htmlString=[[[[[[[[[htmlString stringByReplacingOccurrencesOfString:@"<tr>" withString:@"|"]stringByReplacingOccurrencesOfString:@"</tr>" withString:@""]stringByReplacingOccurrencesOfString:@"</td><td>" withString:@"="]stringByReplacingOccurrencesOfString:@"<td></td>" withString:@"="]stringByReplacingOccurrencesOfString:@"<td>" withString:@""]stringByReplacingOccurrencesOfString:@"</td>" withString:@""]stringByReplacingOccurrencesOfString:@"<ul>" withString:@""]stringByReplacingOccurrencesOfString:@"</ul>" withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@""];
     
     NSLog(@" formatted HTML String ==> %@",htmlString);
     } else {
     htmlString = @"Transaction Failed";
     }*/
    NSString *result = @"";
    if(htmlString != nil){
        NSArray *splitWithH5EndTag = [htmlString componentsSeparatedByString:@"</h5>"];
        if(splitWithH5EndTag != nil && [splitWithH5EndTag count] > 1){
            NSString *resString = splitWithH5EndTag[0];
            NSArray *dataArray = [resString componentsSeparatedByString:@"<h5 style=\"color:#ffffff\">"];
            if(dataArray != nil && [dataArray count] > 1){
                result = dataArray[1];
            }
        }
    }
    if([result isEqualToString:@""]){
        result = @"Transaction Failed";
    }
    NSLog(@" formatted HTML String ==> %@",result);
    return result;
}

-(NSMutableArray *)convertOutputToArray:(NSString *)htmlString{
    NSArray *result = @[];
    
    if(htmlString != nil){
        result = [htmlString componentsSeparatedByString:@"|"];
        // NSLog(@"array: %@", result);
    }
    // NSLog(@" formatted HTML String ==> %@",result);
    return [NSMutableArray arrayWithArray:result];
}

-(NSString *)removeHeaderTag:(NSString *)htmlString{
    
    NSString *endOfHeader=@"<tr";
    NSString *headerStr;
    
    NSRange endRange=[htmlString rangeOfString:endOfHeader];
    if(endRange.location!=NSNotFound){
        NSRange targetRange;
        targetRange.location=0;
        targetRange.length=targetRange.location+endRange.location;
        //        NSLog(@"target length= %lu",(unsigned long)targetRange.length);
        headerStr=[htmlString substringWithRange:targetRange];
        //        NSLog(@"Header string %@",headerStr);
        htmlString=[htmlString stringByReplacingOccurrencesOfString:headerStr withString:@""];
    }
    
    htmlString = [htmlString componentsSeparatedByString:@"</th></tr>"][1];
    
    
    return htmlString;
}

-(NSString *)removeHeaderEnd:(NSString *)htmlString{
    
    NSString *startHeaderEnd=@"</tr></";
    NSString *headerStr;
    
    NSRange endRange=NSMakeRange(0,[htmlString length]);
    if(endRange.location!=NSNotFound){
        NSRange targetRange;
        targetRange.location=[htmlString rangeOfString:startHeaderEnd].location;
        targetRange.length=[htmlString length]-targetRange.location;
        //         NSLog(@"target length= %lu",(unsigned long)targetRange.length);
        headerStr=[htmlString substringWithRange:targetRange];
        //        NSLog(@"Header string %@",headerStr);
        htmlString=[htmlString stringByReplacingOccurrencesOfString:headerStr withString:@""];
    }
    htmlString=[htmlString stringByAppendingString:@"</tr>"];
    return htmlString;
    
}

-(NSString *)validateTableRow:(NSString *)htmlString{
    
    NSString *startRowTag=@"<tr";
    NSString *endRowTag=@">";
    NSString *substringRow;
    
    NSRange startRange=[htmlString rangeOfString:startRowTag];
    
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [htmlString length] - targetRange.location;
        NSRange endRange = [htmlString rangeOfString:endRowTag options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            //            NSLog(@"%@", [htmlString substringWithRange:targetRange]);
            substringRow=[htmlString substringWithRange:targetRange];
            htmlString=[htmlString stringByReplacingOccurrencesOfString:substringRow withString:@""];
        }
    }
    return htmlString;
}

-(NSString *)validateTableData:(NSString *)htmlString{
    
    NSString *startDataTag=@"<td";
    NSString *endDataTag=@">";
    NSString *substringData;
    
    NSRange startRange=[htmlString rangeOfString:startDataTag];
    
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [htmlString length] - targetRange.location;
        NSRange endRange = [htmlString rangeOfString:endDataTag options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            //            NSLog(@"%@", [htmlString substringWithRange:targetRange]);
            substringData=[htmlString substringWithRange:targetRange];
            htmlString=[htmlString stringByReplacingOccurrencesOfString:substringData withString:@""];
        }
    }
    return htmlString;
}

- (IBAction)cancelNav:(id)sender
{
    result = @"Transaction Failed!";
    NSLog(@"Transaction Cancelled!!!");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myDelegate secondviewcontrollerDissmissed:resultFromCallback];

    // [self.myDelegate secondviewcontrollerDissmissed:resultFromCallback];
    // [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*-(NSString*)hmacSHA512:(NSString*)data withKey:(NSString *)key {
    
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *strnew = [[NSString alloc] initWithData:hash encoding:NSUTF8StringEncoding];
    
    NSString* newStr = [NSString stringWithUTF8String:[hash bytes]];
    
    NSLog(@"strnew%@",newStr);
    
    
    return strnew;
}*/

-(NSString*)hmacSHA512:(NSString*)dataStr withKey:(NSString *)keyStr {
    
    NSData *key = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataIn =[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512,
           key.bytes,
           key.length,
           dataIn.bytes,
           dataIn.length,
           macOut.mutableBytes);
    NSString * newStr = [[NSString alloc] initWithData:macOut encoding:NSASCIIStringEncoding];
    
    //NSLog(@"strnew%@  macOut%@",newStr,macOut);
    
    
    return [self hexadecimalString:(macOut)];
}

- (NSString *)hexadecimalString: (NSMutableData*)data {
    
   
//    NSUInteger len = [data length];
//    Byte *byteData = (Byte*)malloc(len);
//    memcpy(byteData, [data bytes], len);
//
     const unsigned char *dataBuffer = data.bytes;
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger dataLength = data.length;
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength *2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}


-(NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {  value |= (0xFF & input[j]);  }  }  NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
/*
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{

    NSLog(@" redirection being done ");
    
}
*/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                                message:nil
                                                                         preferredStyle:UIAlertControllerStyleAlert];
       [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             completionHandler();
                                                         }]];
       [self presentViewController:alertController animated:YES completion:^{}];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
  if (!navigationAction.targetFrame.isMainFrame) {
    [webView loadRequest:navigationAction.request];
  }

  return nil;
}
/*
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.targetFrame == nil) {
        // WKWebView ignores links that open in new window
        [webView loadRequest:navigationAction.request];
    }

    // always pass a policy to the decisionHandler
    decisionHandler(WKNavigationActionPolicyAllow);
}
 */
@end

