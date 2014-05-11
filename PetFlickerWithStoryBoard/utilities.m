//
//  utilities.m
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/9/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "utilities.h"
#import "FMDatabase.h"

@implementation utilities

+(void)CreateLocalDBAndTable
{
    NSLog(@"%@",LOCALDBFILEPATH);
    FMDatabase *db = [FMDatabase databaseWithPath:LOCALDBFILEPATH];
    [db open];
    // Feed table
    [db executeUpdate:@"CREATE TABLE Feeds (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, q_id INTEGER, user_name TEXT, MESSAGE TEXT,posted_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"];
    [db executeUpdate:@"CREATE TABLE Images (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, filename TEXT)"];
    [db executeUpdate:@"CREATE TABLE PersonalTimeline (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, q_id INTEGER, user_name TEXT, MESSAGE TEXT,posted_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"];
    
    NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
    FMDBQuickCheck([db executeQuery:@"select * from WORLDMESSAGE"] == nil);
}


+(NSDictionary*)GetDetailAddressInfoFromLat:(NSString*)Lat andLongt:(NSString*)Longt
{
    
    if(!Lat||!Longt) return nil;
    
    NSString * urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",Lat,Longt];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest  *request = [ASIHTTPRequest  requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        // NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding]);
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              
                              options:kNilOptions
                              error:&error];
        
        NSArray* results = [json objectForKey:@"results"]; //2
        if([results count]==0) return nil;
        NSDictionary * selectedResult;
        for (NSDictionary*result in results) {
            NSArray * types = [result objectForKey:@"types"];
            if ([types[0] isEqualToString:@"neighborhood"]) {
                selectedResult = result;
            }
        }
        
        if (selectedResult.count==0||selectedResult==nil) {
            for (NSDictionary*result in results) {
                NSArray * types = [result objectForKey:@"types"];
                if ([types[0] isEqualToString:@"sublocality"]||[types[0] isEqualToString:@"sublocality_level_1"]) {
                    selectedResult = result;
                }
            }
        }
        
        if (selectedResult.count==0||selectedResult==nil) {
            for (NSDictionary*result in results) {
                NSArray * types = [result objectForKey:@"types"];
                if ([types[0] isEqualToString:@"administrative_area_level_2"]) {
                    selectedResult = result;
                }
            }
        }
        
        if (selectedResult.count==0||selectedResult==nil) {
            for (NSDictionary*result in results) {
                NSArray * types = [result objectForKey:@"types"];
                if ([types[0] isEqualToString:@"bus_station"]) {
                    selectedResult = result;
                }
            }
        }
        
        NSString * CityName;
        NSString * neighborhood=nil;
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        NSArray * AddressComponents = [selectedResult objectForKey:@"address_components"];
        for (NSDictionary * AD in AddressComponents) {
            if([(NSArray*)[AD objectForKey:@"types"] count]>0)
            {
                NSString * type = [(NSArray*)[AD objectForKey:@"types"] objectAtIndex:0];
                if([type isEqualToString:@"locality"])
                {
                    CityName = [AD objectForKey:@"long_name"];
                    [dict setObject:CityName forKey:@"City"];
                }
            }
            
        }
        
        
        // 分层选取
        NSDictionary * AD=AddressComponents[0];
        neighborhood = [AD objectForKey:@"short_name"];
        if (neighborhood) {
            [dict setObject:neighborhood forKey:@"Neighborhood"];
        }
        
        
        if ([dict objectForKey:@"City"]==nil) {
            CityName = [utilities GetCityFromLat:Lat andLongt:Longt];
            [dict setObject:CityName forKey:@"City"];
        }
        return dict;
        
    }else
    {
        NSLog(@"Get city name failed");
    }
    return nil;
}


+(NSString*)GetCityFromLat:(NSString*)Lat andLongt:(NSString*)Longt
{
    
    if(!Lat||!Longt) return @"unkonw";
    
    NSString * urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",Lat,Longt];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest  *request = [ASIHTTPRequest  requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        // NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding]);
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              
                              options:kNilOptions
                              error:&error];
        
        NSArray* Weather = [json objectForKey:@"results"]; //2
        NSString * CityName;
        if([Weather count]==0) return nil;
        NSDictionary *AA = [Weather objectAtIndex:0];
        NSArray * AddressComponents = [AA objectForKey:@"address_components"];
        for (NSDictionary * AD in AddressComponents) {
            if([(NSArray*)[AD objectForKey:@"types"] count]>0)
            {
                NSString * type = [(NSArray*)[AD objectForKey:@"types"] objectAtIndex:0];
                if([type isEqualToString:@"locality"])
                {
                    CityName = [AD objectForKey:@"long_name"];
                }
            }
            
        }
        
        return CityName;
        
    }else
    {
        NSLog(@"Get city name failed");
    }
    return nil;
}



@end
