//
//  SMAccessoryView.m
//  SMTagFieldExample
//
//  Created by Jack Shurpin on 11/12/13.
//  Copyright (c) 2013 Shai Mishali. All rights reserved.
//

#import "SMAccessoryView.h"

@implementation SMAccessoryView
{
    UIView              *tagsView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
           [self setupUI];
    }
    return self;
}


@synthesize tags;


-(void)setTags:(NSArray *)aTags{
    tags = aTags;
    [self layoutTags];
}

#pragma mark - View Flow

-(void)awakeFromNib{
    [self setupUI];
    [super awakeFromNib];
}


//mostly a copy of code in SMTagField
#pragma mark - Private Methods
-(void)setupUI{
    self.backgroundColor        = [UIColor whiteColor];
    self.opaque                 = NO;
    self.userInteractionEnabled = YES;
    
    tags                        = @[];
    
    tagsView                    = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0,0)];
    tagsView.backgroundColor    = [UIColor clearColor];
    
    // Add tagsView
    if(![tagsView isDescendantOfView: self])
        [self addSubview: tagsView];
    
}

-(void)layoutTags{
    
    [tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect tagsFrame        = tagsView.frame;
    tagsFrame.size          = CGSizeMake(0,  self.frame.size.height);
    tagsView.frame          = tagsFrame;
    
    
    for(NSString *txtTag in tags){
        SMTag *tag              = [[SMTag alloc] initWithTag: txtTag];
        
        [tag addTarget:self action:@selector(tagTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect tagFrame         = tag.frame;
        tagFrame.origin.x       = tagsView.frame.size.width + 5;
        tagFrame.origin.y       = (self.frame.size.height - tag.frame.size.height) / 2;
        tag.frame               = tagFrame;
        
        tagsFrame               = tagsView.frame;
        tagsFrame.size.width   += (tag.frame.size.width + 5);
        tagsView.frame          = tagsFrame;
        
        [tagsView addSubview: tag];
    }

    //update content size to match tagsView
    self.contentSize = tagsFrame.size;

}

-(void)tagTapped:(SMTag *)tag {
    if (self.autoCompleteDelegate && [self.autoCompleteDelegate respondsToSelector:@selector(autoCompleteTagTapped:)]) {
        [self.autoCompleteDelegate autoCompleteTagTapped:tag];
    }
}
         
@end
