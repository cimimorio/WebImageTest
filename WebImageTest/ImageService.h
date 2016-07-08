//
//  ImageService.h
//  DriveFinder
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 xdlh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(id data);

@interface ImageService : NSObject

@property (copy) Block block;

+(instancetype)share;

-(void)loadImage:(NSString *)imageStr complet:(Block)complet;



@end
