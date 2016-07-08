//
//  ImageService.m
//  DriveFinder
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 xdlh. All rights reserved.
//

#import "ImageService.h"
#import <AppKit/AppKit.h>
@interface ImageService ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong) NSMutableData *connectionData;
@property (strong) NSURLConnection *connection;
@end
@implementation ImageService

+(instancetype)share{
	static ImageService *service = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		service = [[ImageService alloc] init];
	});
	return service;
}

-(instancetype)init{
	if (self = [super init]) {
		
	}
	return self;
}


-(void)loadImage:(NSString *)imageStr complet:(Block)complet{
	
	NSURL    *url = [NSURL URLWithString:imageStr];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	NSMutableData *data = [[NSMutableData alloc] init];
	
	self.connectionData = data;
	
//	[data release];
	
	NSURLConnection *newConnection = [[NSURLConnection alloc]
									  
									  initWithRequest:request
									  
									  delegate:self
									  
									  startImmediately:YES];
	
	self.connection = newConnection;
	
	
	
//	[newConnection release];
	
	if (self.connection != nil){
		
		NSLog(@"Successfully created the connection");
		
	} else {
		
		NSLog(@"Could not create the connection");
		
	}
	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"&&&&&&&&%@",[NSThread currentThread]);
	NSLog(@"---%@",error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	NSLog(@"&&&&&&&&%@",[NSThread currentThread]);

	self.block([[NSImage alloc]initWithData:data]);
//	NSLog(@"%@",data);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	NSLog(@"&&&&&&&&%@",[NSThread currentThread]);

	NSLog(@"-----%@",response);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	
	[self.connectionData setLength:0];
}
@end
