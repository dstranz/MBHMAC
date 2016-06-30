//
//  NSString+MBHMAC.m
//  MBHMAC
//
//
//  Created by Marcel Borsten on 5/21/13.
//  Copyright (c) 2013 Marcel Borsten All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "NSString+MBHMAC.h"

@implementation NSString (MBHMAC)

-(NSString *)hmacWithHashingAlgorithm:(CCHmacAlgorithm)algorithm
                                  key:(NSString *)keyString
{
    const char *key = [keyString cStringUsingEncoding:NSUTF8StringEncoding];
    const char *data = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[[self lengthForAlgorithm:algorithm]];
    CCHmac(algorithm, key, strlen(key), data, strlen(data), cHMAC);
    NSData *resultData = [[NSData alloc] initWithBytes:cHMAC
                                                length:sizeof(cHMAC)];
    char *utf8;
    utf8 = (char *)resultData.bytes;
    NSMutableString *hex = [NSMutableString string];
    for(int i = 0; i <  resultData.length; i++) [hex appendFormat:@"%02X" , *utf8++ & 0x00FF];
    return [NSString stringWithFormat:@"%@", hex];
}

-(int)lengthForAlgorithm:(CCHmacAlgorithm)a
{
    int length = 0;

    switch (a) {
        case kCCHmacAlgSHA1:
            length = CC_SHA1_DIGEST_LENGTH;
            break;
        case kCCHmacAlgMD5:
            length = CC_MD5_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA256:
            length = CC_SHA256_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA384:
            length = CC_SHA384_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA512:
            length = CC_SHA512_DIGEST_LENGTH;
            break;
    }
    return length;
}

@end