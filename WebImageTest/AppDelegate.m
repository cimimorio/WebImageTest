//
//  AppDelegate.m
//  WebImageTest
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageService.h"
#import "AFNetworking.h"
@interface AppDelegate ()
@property (weak) IBOutlet NSImageView *imgView;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *startBtn;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	
	
	
}
- (IBAction)startBtnClicked:(id)sender {
//	[[ImageService share] loadImage:self.textField.stringValue complet:nil];
//	[ImageService share].block = ^(NSImage *image){
//		NSLog(@"%@",image);
//		[_imgView setImage:image];
//	};
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
	NSURL *URL = [NSURL URLWithString:_textField.stringValue];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
																	 progress:nil
																  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
	{
		NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
																			  inDomain:NSUserDomainMask
																	 appropriateForURL:nil
																				create:NO
																				 error:nil];
		return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
	} completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[_imgView setImage:[[NSImage alloc] initWithContentsOfURL:filePath]];
		});
		NSLog(@"File downloaded to: %@ and current thread %@", filePath,[NSThread currentThread]);
	}];
	[downloadTask resume];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

@end
