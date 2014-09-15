//
//  HotelListVC.m
//  Foodie
//
//  Created by Manish Kumar on 9/8/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HotelListVC.h"
#import "HotelListVC+TopBar.h"
#import "HotelListVC+LocationUpdate.h"

@interface HotelListVC() <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation HotelListVC
-(void)viewDidLoad{
    [super viewDidLoad];
    [self topBarViewDidLoad];
    [self locationUpdateDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self topBarViewDidAppear:animated];
    [self locationUpdateDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self topBarViewDidDisappear:animated];
    [self locationUpdateDidDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = nil;

    [tableView dequeueReusableCellWithIdentifier:@"Blank Cell"];

	if(cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Blank Cell"];
	}
	[cell setNeedsLayout];
    cell.backgroundColor=[UIColor clearColor];
    return  cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2); // called when search results button pressed
{

}
@end
