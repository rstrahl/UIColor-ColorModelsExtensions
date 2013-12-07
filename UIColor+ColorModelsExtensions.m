//
//  UIColor+ColorModelsExtensions.m
//
//  Created by Rudi Strahl on 2012-10-08.

#import "UIColor+ColorModelsExtensions.h"

@implementation UIColor (ColorModelsExtensions)

+ (UIColor *)colorWithRGBHex:(int)hexColor
{
    return [UIColor colorWithRed:((hexColor >> 16) & 0xFF) / 255.0
                           green:((hexColor >> 8) & 0xFF) / 255.0
                            blue:((hexColor) & 0xFF) / 255.0
                           alpha:1.0f];
}

+ (UIColor *)colorWithRGBAHex:(int)hexColor
{
    return [UIColor colorWithRed:((hexColor >> 24) & 0xFF) / 255.0
                           green:((hexColor >> 16) & 0xFF) / 255.0
                            blue:((hexColor >> 8) & 0xFF) / 255.0
                           alpha:((hexColor) & 0xFF) / 255.0];
}

+ (int)hexFromColor:(UIColor *)color
{
    CGFloat red, green, blue, alpha = 0.0f;
    
    // This is a non-RGB color
    if(CGColorGetNumberOfComponents(color.CGColor) == 2)
    {
        CGFloat white, alpha;
        [color getWhite:&white alpha:&alpha];
        red = green = blue = white;
    }
    else
    {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    }
    
    int colorValue = 0;
    colorValue += (int)roundf(red * 255) << 24;
    colorValue += (int)roundf(green * 255) << 16;
    colorValue += (int)roundf(blue * 255) << 8;
    colorValue += (int)roundf(alpha * 255);
    return colorValue;
}

+ (void)convertHexColor:(int)hexColor toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue
{
    *red = ((int)roundf(hexColor * 255) >> 16) & 0xff;
    *green = ((int)roundf(hexColor * 255) >> 8) & 0xff;
    *blue = ((int)roundf(hexColor) & 0xff);
}

+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHexColor:(int *)hexColor
{
    hexColor = 0;
    hexColor += (int)roundf(red * 255) << 16;
    hexColor += (int)roundf(green * 255) << 8;
    hexColor += (int)roundf((blue * 255));
}

+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)hue saturation:(CGFloat *)saturation value:(CGFloat *)value
{
    CGFloat max, min, chroma;
    
    // calculate chroma
    max = fmaxf(red, fmaxf(green, blue));
    min = fminf(red, fminf(green, blue));
    chroma = max - min;
    
    // calculate value
    *value = max;
    
    // calculate saturation
    if (chroma > 0.0f)
        *saturation = chroma / *value;
    else
    {
        *saturation = *hue = 0.0f;
        return;
    }
    
    *hue = [self hueForRed:red green:green blue:blue chroma:chroma max:max];
}

+ (void)convertHue:(CGFloat)hue saturation:(CGFloat)saturation value:(CGFloat)value toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue
{
    // calculate chroma
    CGFloat chroma = value * saturation;
    
	// Check for saturation; if there isn't any just return the lightness value for each, which results in grayscale.
	if (saturation == 0)
    {
		*red = *green = *blue = value;
		return;
	}
    
    // calculate RGB
    CGFloat red1, green1, blue1;
    [self calculateRed:&blue1 green:&green1 blue:&red1 withHue:hue chroma:chroma];
    
    CGFloat min = value - chroma;
    *red = red1 + min;
    *green = green1 + min;
    *blue = blue1 + min;
}

+ (void)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness
{
    CGFloat max, min, chroma;
    
    // calculate chroma
    max = fmaxf(red, fmaxf(green, blue));
    min = fminf(red, fminf(green, blue));
    chroma = max - min;
    
    // calculate lightness
    *lightness = 0.5f * (max + min);
    if (*lightness <= 0.0f)
    {
        *hue = *saturation = *lightness = 0.0f;
        return;
    }

    // calculate saturation
    if (chroma > 0.0f)
        *saturation = chroma / (1 - fabsf(2 * *lightness - 1));
    else
    {
        *saturation = *hue = 0.0f;
        return;
    }
    
    // calculate hue
    *hue = [self hueForRed:red green:green blue:blue chroma:chroma max:max];
}

+ (void)convertHue:(CGFloat)hue saturation:(CGFloat)saturation luminosity:(CGFloat)luminosity toRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue
{
    // calculate chroma
    CGFloat chroma = (1 - fabsf(2 * luminosity - 1)) * saturation;
    
	// Check for saturation; if there isn't any just return the lightness value for each, which results in grayscale.
	if (saturation == 0)
    {
		*red = *green = *blue = luminosity;
		return;
	}

    // calculate RGB
        CGFloat red1, green1, blue1;
    [self calculateRed:&red1 green:&green1 blue:&blue1 withHue:hue chroma:chroma];
    
    CGFloat min = luminosity - (chroma / 2);
    *red = red1 + min;
    *green = green1 + min;
    *blue = blue1 + min;
}

#pragma mark - Private Methods

+ (CGFloat)hueForRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue chroma:(CGFloat)chroma max:(CGFloat)max
{
    CGFloat hue = 0.0f;
    if (red == max)
        hue = (green - blue) / chroma;
    else if (green == max)
        hue = 2 + (blue - red) / chroma;
    else if (blue == max)
        hue = 4 + (red - green) / chroma;
    hue *= 60.0f;
    if (hue < 0.0f)
        hue += 360.0f;
    hue /= 360.0f;
    return hue;
}

+ (void)calculateRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue withHue:(CGFloat)hue chroma:(CGFloat)chroma
{
    // calculate RGB
    int hueD;
    hue *= 6.0f;
	hueD = floor(hue);
    CGFloat x = chroma * (1 - fabsf(hueD % 2 - 1));
	switch (hueD)
    {
		case 0:
        {
			*blue = chroma;
			*green = x;
			*red = 0;
			break;
        }
		case 1:
        {
			*blue = x;
			*green = chroma;
			*red = 0;
			break;
        }
		case 2:
        {
			*blue = 0;
			*green = chroma;
			*red = x;
			break;
        }
		case 3:
        {
			*blue = 0;
			*green = x;
			*red = chroma;
			break;
        }
		case 4:
        {
			*blue = x;
			*green = 0;
			*red = chroma;
			break;
        }
		default:
        {
			*blue = chroma;
			*green = 0;
			*red = x;
			break;
        }
	}
}

@end
