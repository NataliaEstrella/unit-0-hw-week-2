//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;

//My Messod
- (BOOL) codeBreaker:(NSString *)stringA also:(NSString *)stringB;
@end


@implementation CaesarCipher

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";
    
    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);
        
        result[i] = allchars[new_idx];
    }
    
    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
    
    //    My Codesaster
}
- (BOOL) codeBreaker:(NSString *)stringA also:(NSString *)stringB {
    
    for (int i = 1; i < 25; i++) {
        NSString *decodedStringA = [self decode:stringA offset:i];
        
        for (int j = 1; j < 25; j++) {
            NSString *decodedStringB = [self decode:stringB offset:j];
            
            if ([decodedStringA isEqualToString:decodedStringB]) {
                return YES;
            }
        }
    }
    return NO;
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    
    CaesarCipher *cipher = [[CaesarCipher alloc] init];
    
    NSLog(@"%@", [cipher encode:@"natalia" offset:2]);
    NSLog(@"%@", [cipher encode:@"natalia" offset:3]);
    
    
    BOOL stringAEqualToStringB = [cipher codeBreaker:@"pcvcnkc" also:@"qdwdolo"];
    NSLog(@"%@", @(stringAEqualToStringB));
    
}
