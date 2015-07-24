//
//  TextBubble.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/23/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "TextBubble.h"
#import <Masonry/Masonry.h>

@interface TextBubble()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation TextBubble

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    UIImage *img = [[UIImage imageNamed:@"noBorderTB"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.imageView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:14.0];
    self.label.text = self.text;
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

-(void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

@end
