//
//  UIViewController+Blocks.m
//
//  Created by Manish Kumar - Imported on 6/17/13.
//
//

#import "UIViewController+Blocks.h"
#import <objc/runtime.h>


@implementation UIViewController (Blocks)

#pragma mark - associated object getter / setter
static char ASSOCIATED_OBJECT_IDENTIFIER;

- (void)setAssociatedObject:(NSDictionary *)obj
{
    if (obj == nil) {
        [self.class removeAssociatedObject:self];
        return;
    }
    
    //If there are any existing UIViewController around, we don't want to overwrite its data.
    NSDictionary *dict =  objc_getAssociatedObject(self.class, &ASSOCIATED_OBJECT_IDENTIFIER);
    NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    
    //temporary place holder.
    [mutableDict setObject:obj forKey:[NSValue valueWithNonretainedObject:self]];
    
    objc_setAssociatedObject([self class], &ASSOCIATED_OBJECT_IDENTIFIER, mutableDict, OBJC_ASSOCIATION_COPY_NONATOMIC);

    //should not need to do this as we remove the associated object
    //immediately after calling onLoad.
    typeof(self) __weak weakSelf = self;
    [self addDeallocBlock:^{
        [UIViewController removeAssociatedObject:weakSelf];
    }];
}

- (NSDictionary *)associatedObject
{
    NSDictionary *dict =  objc_getAssociatedObject(self.class, &ASSOCIATED_OBJECT_IDENTIFIER);
    if (dict == nil)
        return nil;
    NSDictionary *obj = [dict objectForKey:[NSValue valueWithNonretainedObject:self]];
    return obj;
}

+ (void)removeAssociatedObject:(UIViewController *)this
{
    NSDictionary *dict =  objc_getAssociatedObject(self.class, &ASSOCIATED_OBJECT_IDENTIFIER);
    
    NSMutableDictionary *mutableDict;
    if (dict){
        mutableDict = [dict mutableCopy];
        [mutableDict removeObjectForKey:[NSValue valueWithNonretainedObject:this]];
    }
    
    //Update the dictionary associated 
    if ([mutableDict count])
        objc_setAssociatedObject([self class], &ASSOCIATED_OBJECT_IDENTIFIER, mutableDict, OBJC_ASSOCIATION_COPY_NONATOMIC);
    else //or nuke the empty dictionary
        objc_setAssociatedObject([self class], &ASSOCIATED_OBJECT_IDENTIFIER, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setBlock:(VoidBlock)block forKey:(NSString *)key
{
    NSDictionary *dict = [self associatedObject];
    if (dict == nil) {
        if (block) {
            dict = @{key : block};
            [self setAssociatedObject:dict];
        }
    }
    else{
        NSMutableDictionary *mutableDict = [dict mutableCopy];
        if (block)
            mutableDict[key] = block;
        else
            [mutableDict removeObjectForKey:key];
        
        [self setAssociatedObject:mutableDict];
    }
}

- (VoidBlock)blockForKey:(NSString *)key
{
    NSDictionary *dict =  objc_getAssociatedObject(self.class, &ASSOCIATED_OBJECT_IDENTIFIER);
    if (dict){
        NSDictionary *obj = [dict objectForKey:[NSValue valueWithNonretainedObject:self]];
        VoidBlock block = obj[key];
        return block;
    }
    return nil;
}

- (void)onViewDidLoad:(VoidBlock)block
{
    [self setBlock:block forKey:@"viewDidLoad"];
}

- (void)onViewDidAppear:(VoidBlock)block
{
    [self setBlock:block forKey:@"viewDidAppear"];
}

- (void)onNextViewDidAppear:(VoidBlock)block
{
    [self setBlock:block forKey:@"nextViewDidAppear"];
}

- (void)onViewDidDisappear:(VoidBlock)block
{
    [self setBlock:block forKey:@"viewDidDisappear"];
}

- (void)onNextViewDidDisappear:(VoidBlock)block
{
    [self setBlock:block forKey:@"nextViewDidDisappear"];
}

+ (void)load
{
    [self swizzleSelector:@selector(viewDidLoad)
             withSelector:@selector(swizzled_viewDidLoad)];
    [self swizzleSelector:@selector(viewDidAppear:)
             withSelector:@selector(swizzled_viewDidAppear:)];
    [self swizzleSelector:@selector(viewDidDisappear:)
             withSelector:@selector(swizzled_viewDidDisappear:)];
}

- (void)swizzled_viewDidLoad
{
    [self swizzled_viewDidLoad];

    VoidBlock block = [self blockForKey:@"viewDidLoad"];
    if (block)
        block();
}

- (void)swizzled_viewDidAppear:(BOOL)animated
{
    [self swizzled_viewDidAppear:animated];
    
    VoidBlock block1 = [self blockForKey:@"viewDidAppear"];
    if (block1)
        block1();
    
    VoidBlock block2 = [self blockForKey:@"nextViewDidAppear"];
    if (block2)
        block2();
    [self setBlock:nil forKey:@"nextViewDidAppear"];
}

- (void)swizzled_viewDidDisappear:(BOOL)animated
{
    [self swizzled_viewDidDisappear:animated];
    
    VoidBlock block1 = [self blockForKey:@"viewDidDisappear"];
    if (block1)
        block1();
    
    VoidBlock block2 = [self blockForKey:@"nextViewDidDisappear"];
    if (block2)
        block2();
    [self setBlock:nil forKey:@"nextViewDidDisappear"];
}

@end
