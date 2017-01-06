//
//  ViewController.m
//  Figurez V1
//
//  Created by Ariel Krieger on 12/12/2016.
//  Copyright © 2016 hof. All rights reserved.
//

#import "ViewController.h"
#import "UIColor_Extensions.h"
#import "UIView_Extensions.h"
#import "FigurezCollectionViewCell.h"
#import "MiniFigurezCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *figurezExpandButton;
- (IBAction)figurezExpandButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *chestClaimView;
- (IBAction)cheatButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *gameCheatView;
- (IBAction)figurezViewDismissed:(id)sender;
- (IBAction)bgToggled:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *figurezCollectionView;
@property (weak, nonatomic) IBOutlet UIView *figurezView;
@property (weak, nonatomic) IBOutlet UIImageView *bgLobby;
@property (weak, nonatomic) IBOutlet UIImageView *bgGame;
@property (weak, nonatomic) IBOutlet UIButton *figurezButton;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *figuresButtonLeadingConstraint;
- (IBAction)gameCheat1:(id)sender;
- (IBAction)gameCheat2:(id)sender;
- (IBAction)gameCheat3:(id)sender;
- (IBAction)gameCheat4:(id)sender;
- (IBAction)chestButtonTapped:(id)sender;
- (IBAction)figurezButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chestButton;
@property (assign) BOOL menuContainerIsShowing;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   _figurezView.backgroundColor = [UIColor colorFromHexString:@"000000" alpha:0.9];
    _figurezView.layer.cornerRadius = 10.0;
    _figuresButtonLeadingConstraint.constant = -_figurezButton.frame.size.width;
    [self resetToLobby];
//    [_figurezCollectionView registerClass:[FigurezCollectionViewCell class] forCellWithReuseIdentifier:@"FigureCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (void)resetToLobby {
    _bgLobby.hidden = NO;
    _bgGame.hidden = YES;
    _figurezView.hidden = YES;
    _chestButton.hidden = NO;
    _collectLabel.hidden = NO;
    _gameCheatView.hidden = YES;

}

- (void)resetToGame {
    _bgLobby.hidden = YES;
    _bgGame.hidden = NO;
    _figurezView.hidden = YES;
    _chestButton.hidden = YES;
    _collectLabel.hidden = YES;
    _gameCheatView.hidden = YES;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    int lowerBound = 1;
    int upperBound = 5;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    NSString *imgName = [NSString stringWithFormat:@"p%i.jpg",rndValue];
    NSString *identifier = @"";
    if (collectionView == _figurezCollectionView) {
        identifier = @"FigureCell";
        FigurezCollectionViewCell *cell = (FigurezCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:imgName];
        return cell;
    }
    else {
        identifier = @"Cell";
        MiniFigurezCollectionViewCell *cell = (MiniFigurezCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:imgName];
        return cell;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)figurezButtonTapped:(id)sender {
    _figurezView.hidden = NO;
    _figurezButton.hidden = YES;
    _figurezExpandButton.hidden = YES;
    _chestButton.hidden = YES;
    _collectLabel.hidden = YES;
}

- (IBAction)figurezViewDismissed:(id)sender {
    _figurezView.hidden = YES;
    _figurezButton.hidden = NO;
    _figurezExpandButton.hidden = NO;
    _chestButton.hidden = NO;
    _collectLabel.hidden = NO;
}

- (IBAction)bgToggled:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        [self resetToLobby];
    }
    else {
        [self resetToGame];

    }
}
- (IBAction)gameCheat1:(id)sender {
    [self runGameChestFlowWithEvolution:NO andRankUp:NO];
}

- (IBAction)gameCheat2:(id)sender {
    [self runGameChestFlowWithEvolution:YES andRankUp:NO];
}

- (IBAction)gameCheat3:(id)sender {
    [self runGameChestFlowWithEvolution:YES andRankUp:YES];
}

- (IBAction)gameCheat4:(id)sender {
}

- (void)runGameChestFlowWithEvolution:(BOOL)withEvolution andRankUp:(BOOL)withRankUp {
    
    
    
}
- (IBAction)chestButtonTapped:(id)sender {
}


- (IBAction)cheatButtonTapped:(id)sender {
    if (_bgGame.hidden) {
        
    }
    else {
        _gameCheatView.hidden = NO;
    }
}
- (IBAction)figurezExpandButtonTapped:(id)sender {
    if (_menuContainerIsShowing) {
        self.figuresButtonLeadingConstraint.constant = -_figurezButton.frame.size.width;
    }
    else {
        self.figuresButtonLeadingConstraint.constant = 0 ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    _menuContainerIsShowing = !_menuContainerIsShowing;

    
}
@end
