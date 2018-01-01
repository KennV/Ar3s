//
//  GameViewController.m
//  AresBase iOS
//
//  Created by Kenn Villegas on 1/1/18.
//  Copyright © 2018 Kenn Villegas. All rights reserved.
//

#import "GameViewController.h"
#import <SceneKit/SceneKit.h>
#import "GameController.h"

@interface GameViewController ()

@property (readonly) SCNView *gameView;
@property (strong, nonatomic) GameController *gameController;
/** OKAY Right, instead of - (SCNView *)gameView which is identical in both of these ocntrollers why not make this completely common havea KVCommonGameView AKA
 self.gameController = [[GameController alloc] initWithSceneRenderer:self.gameView];
 */
@end

@implementation GameViewController

- (SCNView *)gameView {
    return (SCNView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameController = [[GameController alloc] initWithSceneRenderer:self.gameView];
    
    // Allow the user to manipulate the camera
    self.gameView.allowsCameraControl = YES;
    
    // Show statistics such as fps and timing information
    self.gameView.showsStatistics = YES;
    
    // Configure the view
    self.gameView.backgroundColor = [UIColor blackColor];
    
    // Add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:self.gameView.gestureRecognizers];
    self.gameView.gestureRecognizers = gestureRecognizers;
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize {
    // Highlight the tapped nodes
    CGPoint p = [gestureRecognize locationInView:self.gameView];
    [self.gameController highlightNodesAtPoint:p];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
