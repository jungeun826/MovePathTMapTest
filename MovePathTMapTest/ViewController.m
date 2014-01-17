//
//  ViewController.m
//  MovePathTMapTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#define APP_KEY @"436686fb-a4ea-3149-b8b1-7b1af6226827"
#define TOOLBAR_HIGHT 64
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *transportType;
@property (strong, nonatomic) TMapMarkerItem *startMark, *endMark;
@property (strong, nonatomic) TMapView *mapView;
@end

@implementation ViewController

- (IBAction)transportTypeChanded:(id)sender {
    [self showPath];
}
-(void)showPath{
    TMapPathData *path = [[TMapPathData alloc]init];
    
    TMapPolyLine *line = [path findPathDataWithType:self.transportType.selectedSegmentIndex startPoint:[self.startMark getTMapPoint] endPoint:[self.endMark getTMapPoint]];
    
    if(line != nil){
        [self.mapView showFullPath:@[line]];
        
        [self.mapView bringMarkerToFront:self.startMark];
        [self.mapView bringMarkerToFront:self.endMark];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [self showPath];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, self.view.frame.size.height-TOOLBAR_HIGHT);
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    [self.view addSubview:self.mapView];
    
    self.startMark = [[TMapMarkerItem alloc]init];
    [self.startMark setIcon:[UIImage imageNamed:@"_Right.png"]];
    TMapPoint *startPoint = [self.mapView convertPointToGpsX:50 andY:50];
    [self.startMark setTMapPoint:startPoint];
    [self.mapView addCustomObject:self.startMark ID:@"START"];
    
    self.endMark = [[TMapMarkerItem alloc]init];
    [self.endMark setIcon:[UIImage imageNamed:@"_Right.png"]];
    TMapPoint *endPoint = [self.mapView convertPointToGpsX:300 andY:300];
    [self.endMark setTMapPoint:endPoint];
    [self.mapView addCustomObject:self.endMark ID:@"END"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
