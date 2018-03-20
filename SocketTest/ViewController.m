//
//  ViewController.m
//  SocketTest
//
//  Created by Ivan Najdanovic on 7/6/16.
//  Copyright © 2016 Deployed Systems. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController{
    SRWebSocket *_webSocket;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear{
    [super viewDidAppear];
    [self.view.window setTitle:@"SocketTest - Closed"];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

#pragma mark - ButtonActions

- (IBAction)openCloseWebsocket:(id)sender {
    if (_webSocket.readyState != SR_OPEN ){
        [self.view.window setTitle:@"SocketTest - Opening"];
        _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:[self.URLTextField stringValue]] protocols:nil allowsUntrustedSSLCertificates:YES];

        [_webSocket setDelegate:self];
        [_webSocket open];

    }else{
        [self.view.window setTitle:@"SocketTest - Closing"];
        [_webSocket close];
    }
}

- (IBAction)sendMessage:(id)sender {
    if (_webSocket.readyState == SR_OPEN ){
        NSString *message = self.RequestTextView.string;
        NSLog(@"Message - %@",message);

        [_webSocket send:self.RequestTextView.string];
        if (self.ResponseTextView.string.length > 0)
            [self.ResponseTextView setString:[NSString stringWithFormat:@"%@\n",self.ResponseTextView.string]];
        [self.ResponseTextView setString:[NSString stringWithFormat:@"%@Sent - %@",self.ResponseTextView.string,self.RequestTextView.string]];
    }
}

- (IBAction)clearResponses:(id)sender {
    [self.ResponseTextView setString:@""];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    [self.view.window setTitle:@"SocketTest - Opened"];
    if (self.ResponseTextView.string.length > 0)
        [self.ResponseTextView setString:[NSString stringWithFormat:@"%@\n",self.ResponseTextView.string]];
    [self.ResponseTextView setString:[NSString stringWithFormat:@"%@Opened - %@",self.ResponseTextView.string,_webSocket.url.absoluteString]];
    [self.openCloseButton setTitle:@"Close"];
    [self.sendButton setEnabled:YES];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    [self.view.window setTitle:@"SocketTest - Failed"];
    if (self.ResponseTextView.string.length > 0)
        [self.ResponseTextView setString:[NSString stringWithFormat:@"%@\n",self.ResponseTextView.string]];
    [self.ResponseTextView setString:[NSString stringWithFormat:@"%@Failed - %@",self.ResponseTextView.string,error.localizedDescription]];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    if (self.ResponseTextView.string.length > 0)
        [self.ResponseTextView setString:[NSString stringWithFormat:@"%@\n",self.ResponseTextView.string]];
    [self.ResponseTextView setString:[NSString stringWithFormat:@"%@Received - %@",self.ResponseTextView.string,message]];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    [self.view.window setTitle:@"SocketTest - Closed"];
    if (self.ResponseTextView.string.length > 0)
        [self.ResponseTextView setString:[NSString stringWithFormat:@"%@\n",self.ResponseTextView.string]];
    [self.ResponseTextView setString:[NSString stringWithFormat:@"%@Closed - %@",self.ResponseTextView.string,reason]];
    [self.openCloseButton setTitle:@"Open"];
    [self.sendButton setEnabled:NO];
}

@end
