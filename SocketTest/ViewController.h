//
//  ViewController.h
//  SocketTest
//
//  Created by Ivan Najdanovic on 7/6/16.
//  Copyright © 2016 Deployed Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SocketRocket/SRWebSocket.h>

@interface ViewController : NSViewController <SRWebSocketDelegate>

@property (weak) IBOutlet NSTextField *URLTextField;
@property (unsafe_unretained) IBOutlet NSTextView *RequestTextView;
@property (unsafe_unretained) IBOutlet NSTextView *ResponseTextView;
@property (weak) IBOutlet NSButton *openCloseButton;
@property (weak) IBOutlet NSButton *sendButton;

@end

