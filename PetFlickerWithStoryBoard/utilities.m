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
    [db executeUpdate:@"CREATE TABLE Feeds (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, q_id INTEGER, user_name TEXT, message TEXT,lat TEXT,longt TEXT,location_description TEXT,posted_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,p_id INTEGER,p_name TEXT)"];
    [db executeUpdate:@"CREATE TABLE Images (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, filename TEXT)"];
    [db executeUpdate:@"CREATE TABLE PersonalTimeline (ID INTEGER PRIMARY KEY AUTOINCREMENT, s_id INTEGER, q_id INTEGER, user_name TEXT, message TEXT,lat TEXT,longt TEXT,location_description TEXT,posted_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)"];
    
    NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
    FMDBQuickCheck([db executeQuery:@"select * from WORLDMESSAGE"] == nil);
    [db close];
}

+(FMDatabase*)OpenDataBase
{
    FMDatabase *db = [FMDatabase databaseWithPath:LOCALDBFILEPATH];
    if (![db open]) {
        // error
        return nil;
    }else
        return db;
}

+(BOOL)InsertFeedWith:(NSString*)s_id userId:(int)q_id name:(NSString*)username message:(NSString*)message lat:(float)lat longt:(float)longt locationDescription:(NSString*)location_description Time:(NSTimeInterval)timeStamp
{
    FMDatabase * db = [utilities OpenDataBase];
    
    BOOL ok =timeStamp!=0?[db executeUpdate:@"INSERT INTO Feeds (s_id,q_id,user_name,message,lat,longt,location_description,posted_time) VALUES (?,?,?,?,?,?,?,?)",
        s_id,
        q_id,
        message,
        [NSString stringWithFormat:@"%f",lat],
        [NSString stringWithFormat:@"%f",longt],
        location_description,
        [NSString stringWithFormat:@"%.f",timeStamp]
        ]:
    [db executeUpdate:@"INSERT INTO Feeds (s_id,q_id,user_name,message,lat,longt,location_description) VALUES (?,?,?,?,?,?,?)",
     s_id,
     q_id,
     message,
     [NSString stringWithFormat:@"%f",lat],
     [NSString stringWithFormat:@"%f",longt],
     location_description
     ];
    [db close];
    return ok;
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


+(NSString *)CreateUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}

#pragma mark ASIHTTP

+(BOOL)RegisterNewUser:(NSString*)username andPassword:(NSString*)password
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/register",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        return [backValue boolValue];
    }else
    {
        //TODO: Add NSAlert
        return NO;
    }
}

+(NSDictionary*)LoginUser:(NSString*)username andPassword:(NSString*)password
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/login",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"has_access"];
        if([backValue boolValue])
        {
            return json;
        }else
        {
            return @{@"error":@"someErrors"};
        }
    }else
    {
        return @{@"error":@"someErrors"};
    }
}

+(NSDictionary*)GetUserInfo:(NSString*)token
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/get_user_info",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return json;
        }else
        {
            return @{@"error":@"someErrors"};
        }
    }else
    {
        return @{@"error":@"someErrors"};
    }

}



#pragma mark userPlist related
+(BOOL)SetupUserPlist
{
    // create appprofilePlist
    NSString *dataPath1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath1])
    {
        NSMutableDictionary *theMutantDict = [[NSMutableDictionary alloc] init];
       return [theMutantDict writeToFile:dataPath1 atomically:YES];
    }
    return NO;
}

+(BOOL)UserIsRegisted
{
    if([utilities ReadProfilePlist:@"qid"]!=nil&&[utilities ReadProfilePlist:@"password"]!=nil)
    {
        return YES;
    }else return NO;
}


+(id)ReadProfilePlist:(NSString*)Key
{
    if (Key==nil) {
        return @"";
    }
    NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [data objectForKey:Key];
}


+(BOOL)WriteToProfilePlist:(NSString*)Key Value:(NSObject*)value
{
    if (Key==nil) {
        return NO;
    }
    [utilities SetupUserPlist];
    NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if(!value) return NO;
    [data setObject:value forKey:Key];
    [data  writeToFile:plistPath atomically:YES];
    return YES;
}

+(BOOL)UpdateOneUserAttribute:(enum UserUpdateParms)Key Value:(NSObject*)value Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/update_user_info",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:value forKey:[USERUPDATPARM objectAtIndex:(int)Key]];
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}


+(BOOL)UpdateUserAttributes:(NSDictionary*)dict Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@user/update_user_info",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    for(id key in dict)
    {
        [request setPostValue:[dict objectForKey:key] forKey:[USERUPDATPARM objectAtIndex:[key intValue]]];
    }
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}


+(BOOL)Follow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@follow/follow_user",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:thisQid forKey:@"qid"];
    [request setPostValue:otherQid forKey:@"other_qid"];
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}

+(BOOL)UnFollow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/follow/unfollow_user",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:thisQid forKey:@"qid"];
    [request setPostValue:otherQid forKey:@"other_qid"];
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}

+(BOOL)DeleteStory:(NSNumber*)qid Sid:(NSNumber*)sid Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/story/delete_story",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:qid forKey:@"qid"];
    [request setPostValue:sid forKey:@"other_qid"];
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response //1
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}

+(int)CreateStory:(NSNumber*)qid Message:(NSString*)message OtherParms:(NSDictionary*)params Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/story/create_story",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:message forKey:@"message"];
    [request setPostValue:qid forKey:@"qid"];
    for(id key in params)
    {
        [request setPostValue:[params objectForKey:key] forKey:[STORYUPDATPARM objectAtIndex:[key intValue]]];
    }
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response
                              options:kNilOptions
                              error:&error];
        NSNumber * sid = [json objectForKey:@"sid"];
        if(sid!=nil)
        {
            return [sid intValue];
        }else
        {
            return -1;
        }
    }else
    {
        return -1;
    }
}

+(BOOL)CreatePetWithUserName:(NSString*)userName OtherParms:(NSDictionary*)params Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/pet/create_pet",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:userName forKey:@"username"];
    for(id key in params)
    {
        [request setPostValue:[params objectForKey:key] forKey:[PETUPDATPARM objectAtIndex:[key intValue]]];
    }
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}

+(BOOL)UpdatePetWithUpdateParams:(NSDictionary*)dict Token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/pet/update_pet",SERVERADDRESS]];
    ASIFormDataRequest  *request = [ASIFormDataRequest  requestWithURL:url];
    [request setPostValue:userName forKey:@"username"];
    
    if (dict==nil) {
        return NO;
    }
    
    for(id key in dict)
    {
        [request setPostValue:[dict objectForKey:key] forKey:[PETUPDATPARM objectAtIndex:[key intValue]]];
    }
    [request addRequestHeader:@"Authorization" value:token];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *response = [request responseData];
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:response
                              options:kNilOptions
                              error:&error];
        NSNumber * backValue = [json objectForKey:@"success"];
        if([backValue boolValue])
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}




@end
