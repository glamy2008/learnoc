//
//  main.m
//  prog156
//
//  Created by neusoft on 2018/10/8.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *str1 = @"This is string A";
        NSString *search, *replace;
        NSMutableString *mstr;
        NSRange substr;
        
        mstr = [NSMutableString stringWithString: str1];
        NSLog(@"%@", mstr);
        
        [mstr insertString: @" and string B" atIndex: [mstr length]];
        NSLog(@"%@", mstr);
        
        [mstr appendString: @" and string C"];
        NSLog(@"%@", mstr);
        
        [mstr deleteCharactersInRange: NSMakeRange(16, 13)];
        NSLog(@"%@", mstr);
        
        [mstr setString: @"This is string A"];;
        NSLog(@"%@", mstr);
        
        [mstr replaceCharactersInRange: NSMakeRange(8, 8) withString: @"a mutable string"];
        NSLog(@"%@", mstr);
        
        search = @"This is";
        replace = @"An example of";
        
        substr = [mstr rangeOfString: search];
        if(substr.location != NSNotFound) {
            [mstr replaceCharactersInRange:substr withString:replace];
            NSLog(@"%@", mstr);
        }
        
        search = @"a";
        replace = @"X";
        
        substr = [mstr rangeOfString: search];
        while (substr.location != NSNotFound) {
            [mstr replaceCharactersInRange: substr withString: replace];
            substr = [mstr rangeOfString: search];
        }
        NSLog(@"%@", mstr);
    }
    return 0;
}
