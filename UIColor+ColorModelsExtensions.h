//
//  UIColor+ColorModelsExtensions.h
//
//  Created by Rudi Strahl on 2012-10-08.
//
//  Based on: http://en.wikipedia.org/wiki/HSL_and_HSV

/*
 The MIT License (MIT)
 
 Copyright (C) 2012 Rudi Strahl

 Permission is hereby granted, free of charge, to any person obtaining a copy of this 
 software and associated documentation files (the "Software"), to deal in the Software
 without restriction, including without limitation the rights to use, copy, modify, 
 merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
 permit persons to whom the Software is furnished to do so, subject to the following 
 conditions:

 The above copyright notice and this permission notice shall be included in all copies 
 or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
 THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import <UIKit/UIKit.h>

@interface UIColor (ColorModelsExtensions)

/**
 Converts an RGB int/hex value to a UIColor object.
 @param hexColor An int/hex value containing color data in RGBA format.
 @return A UIColor object based on the color value provided.
 */
+ (UIColor *)colorWithRGBHex:(int)hexColor;

/**
 Converts an RGBA int/hex value to a UIColor object.
 @param hexColor An int/hex value containing color data in RGBA format.
 @return A UIColor object based on the color value provided.
 */
+ (UIColor *)colorWithRGBAHex:(int)hexColor;

/** 
 Converts a UIColor object to an RGBA int/hex value.
 @param color The UIColor object to be converted.
 @return An int/hex value containing color data in RGBA format.
 */
+ (int)hexFromColor:(UIColor *)color;

/**
 Converts an RGB int/hex value to a RGB components.
 @param hexColor An int/hex value containing color data in RGBA format.
 @param On return, the red component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the green component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the blue component of the color object, specified as a value between 0.0 and 1.0.
 */
+ (void)convertHexColor:(int)hexColor toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue;

/**
 Converts RGB components to an RGB int/hex value.
 @param red The red component of the color object, specified as a value between 0.0 and 1.0.
 @param green The green component of the color object, specified as a value between 0.0 and 1.0.
 @param blue The blue component of the color object, specified as a value between 0.0 and 1.0.
  @param On return, an int/hex value containing color data in RGBA format.
 */
+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHexColor:(int *)hexColor;

/**
 Converts RGB components to HSV components.
 @param red The red component of the color object, specified as a value between 0.0 and 1.0.
 @param green The green component of the color object, specified as a value between 0.0 and 1.0.
 @param blue The blue component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the hue component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the saturation component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the value component of the color object, specified as a value between 0.0 and 1.0.
 */
+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)hue saturation:(CGFloat *)saturation value:(CGFloat *)value;

/**
 Converts HSV components to RGB components.
 @param hue The hue component of the color object, specified as a value between 0.0 and 1.0.
 @param saturation The saturation component of the color object, specified as a value between 0.0 and 1.0.
 @param value The value component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the red component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the green component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the blue component of the color object, specified as a value between 0.0 and 1.0.
 */
+ (void)convertHue:(CGFloat)hue saturation:(CGFloat)saturation value:(CGFloat)value toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue;

/**
 Converts RGB components to HSL components.
 @param red The red component of the color object, specified as a value between 0.0 and 1.0.
 @param green The green component of the color object, specified as a value between 0.0 and 1.0.
 @param blue The blue component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the hue component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the saturation component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the luminosity component of the color object, specified as a value between 0.0 and 1.0.
 */
+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness;

/**
 Converts HSL components to RGB components.
 @param hue The hue component of the color object, specified as a value between 0.0 and 1.0.
 @param saturation The saturation component of the color object, specified as a value between 0.0 and 1.0.
 @param luminosity The luminosity component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the red component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the green component of the color object, specified as a value between 0.0 and 1.0.
 @param On return, the blue component of the color object, specified as a value between 0.0 and 1.0.
 */
+ (void)convertHue:(CGFloat)hue saturation:(CGFloat)saturation luminosity:(CGFloat)luminosity toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue;

@end
