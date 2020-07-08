//
//  AtomPayment.h
//  example
//
//  Created by Vikas Kumar on 08/06/20.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import "nb.h"
#import "card.h"
NS_ASSUME_NONNULL_BEGIN

@interface AtomPayment : NSObject <RCTBridgeModule,nbDelegate,cardDelegate>
@property (nonatomic) RCTResponseSenderBlock responseHandler;
@end

NS_ASSUME_NONNULL_END
