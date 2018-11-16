#import "RNNUtils.h"

@implementation RNNUtils
+(double)getDoubleOrKey:(NSDictionary*)dict withKey:(NSString*)key withDefault:(double)defaultResult {
	if ([dict objectForKey:key]) {
		return [dict[key] doubleValue];
	} else {
		return defaultResult;
	}
}

+(BOOL)getBoolOrKey:(NSDictionary*)dict withKey:(NSString*)key withDefault:(BOOL)defaultResult {
	if ([dict objectForKey:key]) {
		return [dict[key] boolValue];
	} else {
		return defaultResult;
	}
}

+(id)getObjectOrKey:(NSDictionary*)dict withKey:(NSString*)key withDefault:(id)defaultResult {
	if ([dict objectForKey:key]) {
		return dict[key];
	} else {
		return defaultResult;
	}
}

+ (NSNumber *)getCurrentTimestamp {
	return [NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970] * 1000];
}

+ (void)stopDescendentScrollViews: (UIView*) view {
	if ([view isKindOfClass:[UIScrollView class]]){
		UIScrollView* scrollView = (UIScrollView*) view;
		CGPoint offset = scrollView.contentOffset;
		[scrollView setContentOffset:offset animated:NO];
	}
    // This won't stop nested scrollview but it will increase performance
	else {
	  for (UIView *subview in view.subviews) {
		[self stopDescendentScrollViews:subview];
	  }
	}
}

+ (UIViewController*) getTopViewController {
	return [self getTopViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*) getTopViewController: (UIViewController*)rootViewController {
	if ([rootViewController isKindOfClass:[UITabBarController class]]) {
		UITabBarController* tabBarController = (UITabBarController*)rootViewController;
		return [self getTopViewController:tabBarController.selectedViewController];
	} else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
		UINavigationController* navigationController = (UINavigationController*)rootViewController;
		return [self getTopViewController:navigationController.visibleViewController];
	} else if (rootViewController.presentedViewController) {
		UIViewController* presentedViewController = rootViewController.presentedViewController;
		return [self getTopViewController:presentedViewController];
	} else {
		return rootViewController;
	}
}

@end
