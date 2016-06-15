//
//  LYLHomeSubjectModel.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "JSONModel.h"

@interface LYLHomeSubjectModel : JSONModel


@property (nonatomic,copy) NSString *pic;

@property (nonatomic,copy) NSString *subDate;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *type;

@property (nonatomic,strong) NSString *subjectId;

@end
