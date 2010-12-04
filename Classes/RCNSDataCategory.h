//
//  RCNSDataCategory.h
//  Texture3
//
//  Created by rcrebs on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DataForFileName)
+ (NSData*)findTextDataForImageNamed:(NSString*)imageName;
@end
