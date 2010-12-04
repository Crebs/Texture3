//
//  RCNSStringCategory.h
//  Texture3
//
//  Created by rcrebs on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (RCNSStringCategory)
-(NSString*)baseFileName;
-(BOOL)isSameStringAs:(NSString*) stringName;
@end
