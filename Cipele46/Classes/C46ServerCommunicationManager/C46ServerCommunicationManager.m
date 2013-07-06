//
//  C46ServerCommunicationManager.m
//  Cipele46
//
//  Created by Miran Brajsa on 7/6/13.
//  Copyright (c) 2013 Miran Brajsa. All rights reserved.
//

#import "C46ServerCommunicationManager.h"

#import "AFNetworking.h"
#import "JSONKit.h"

#define mockupURL @"http://dev.fiveminutes.eu/cipele/api/"

@implementation C46ServerCommunicationManager

- (void)filterCategories {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:mockupURL]];
    [client getPath:@"categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *response = [json_string objectFromJSONString];
        [self.delegate didReceiveFilterCategories:response];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Getting our publications failed: %@", [error localizedDescription]);
    }];
}

@end
