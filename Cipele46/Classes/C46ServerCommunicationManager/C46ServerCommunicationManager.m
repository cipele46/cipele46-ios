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

@interface C46ServerCommunicationManager ()
typedef void (^DelegateCallerBlock)(NSArray *);
- (void)serverCommunicationGetPathWorker:(NSString *)path withBlock:(DelegateCallerBlock)delegateCallerBlock;
@end

@implementation C46ServerCommunicationManager

- (void)serverCommunicationGetPathWorker:(NSString *)path withBlock:(DelegateCallerBlock)delegateCallerBlock {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:mockupURL]];
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *json_string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *response = [json_string objectFromJSONString];
        delegateCallerBlock(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Getting '%@' failed: %@", path, [error localizedDescription]);
    }];
}

- (void)ads {
    [self serverCommunicationGetPathWorker:@"ads" withBlock:^(NSArray *response){
        [self.delegate didReceiveAds:response];
    }];
}

- (void)categories {
    [self serverCommunicationGetPathWorker:@"categories" withBlock:^(NSArray *response){
        [self.delegate didReceiveCategories:response];
    }];
}

- (void)districts {
    [self serverCommunicationGetPathWorker:@"districts" withBlock:^(NSArray *response){
        [self.delegate didReceiveDistricts:response];
    }];
}

@end
