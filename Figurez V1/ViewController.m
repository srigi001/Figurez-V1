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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *figuresButtonLeadingConstraint;
- (IBAction)gameCheat1:(id)sender;
- (IBAction)gameCheat2:(id)sender;
- (IBAction)gameCheat3:(id)sender;
- (IBAction)gameCheat4:(id)sender;
- (IBAction)chestButtonTapped:(id)sender;
- (IBAction)figurezButtonTapped:(id)sender;

@property (assign) BOOL menuContainerIsShowing;

@property (weak, nonatomic) IBOutlet UIView *blueCoinView;
@property (weak, nonatomic) IBOutlet UIView *yellowCoinView;
@property (weak, nonatomic) IBOutlet UIView *redCoinView;
@property (weak, nonatomic) IBOutlet UIView *coinsView;
@property (weak, nonatomic) IBOutlet UIImageView *chestImage;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIImageView *figure1;
@property (weak, nonatomic) IBOutlet UIImageView *figure2;
@property (weak, nonatomic) IBOutlet UIImageView *figure3;
@property (weak, nonatomic) IBOutlet UILabel *congratsLabel;

@property (assign) BOOL withEvolution;
@property (assign) BOOL withRankUp;
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
    _gameCheatView.hidden = YES;
    _chestClaimView.hidden = YES;

}

- (void)resetToGame {
    _bgLobby.hidden = YES;
    _bgGame.hidden = NO;
    _figurezView.hidden = YES;
    _gameCheatView.hidden = YES;
    _chestClaimView.hidden = YES;
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
}

- (IBAction)figurezViewDismissed:(id)sender {
    _figurezView.hidden = YES;
    _figurezButton.hidden = NO;
    _figurezExpandButton.hidden = NO;
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
    
    _withEvolution = withEvolution;
    _withRankUp = withRankUp;
    
    [self setInitialSateCollect];
    [self showChestWithAnimation];
}

- (void)setInitialSateCollect{
    _chestClaimView.alpha = 1;
    _chestClaimView.hidden = false;
    _blueCoinView.alpha = 0;
    _yellowCoinView.alpha = 0;
    _redCoinView.alpha = 0;
    _coinsView.alpha = 0;
    _collectButton.alpha = 0;
    _figure1.alpha = 0;
    _figure2.alpha = 0;
    _figure3.alpha = 0;
    _blueCoinView.center = CGPointMake(440, 90);
    _yellowCoinView.center = CGPointMake(440, 130);
    _redCoinView.center = CGPointMake(440, 170);
    _congratsLabel.alpha = 0;
    _chestImage.alpha = 1;
    _chestImage.center = CGPointMake(300, 400);
    _coinsView.center = CGPointMake(280, 120);
}

- (void)showChestWithAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        _chestImage.center = CGPointMake(300, 150);
        _congratsLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _chestImage.center = CGPointMake(100, 90);
            _blueCoinView.alpha = 1;
            _yellowCoinView.alpha = 1;
            _redCoinView.alpha = 1;
            _coinsView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _collectButton.alpha = 1;
            }];
        }];
        
    }];
}
- (IBAction)didPressCollectButton:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{
        _chestImage.alpha = 0;
        _figure1.alpha = 1;
        _figure2.alpha = 1;
        _figure3.alpha = 1;
        _coinsView.center = CGPointMake(135, -50);
        _collectButton.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _blueCoinView.center = _figure1.center;
            _yellowCoinView.center = _figure2.center;
            _redCoinView.center = _figure3.center;
        } completion:^(BOOL finished) {
            if (!_withEvolution)
            {
                [self noEvolotion];
            }
            else
            {
                [self withEvolotion];
            }
        }];
    }];
}

-(void)noEvolotion{
    [UIView animateWithDuration:0.5 animations:^{
        _blueCoinView.alpha = 0;
        _yellowCoinView.alpha = 0;
        _redCoinView.alpha = 0;
        _figure1.alpha = 0;
        _figure2.alpha = 0;
        _figure3.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _chestClaimView.alpha = 0;
        }];
    }];
}

-(void)withEvolotion{
    [UIView animateWithDuration:0.5 animations:^{
        _yellowCoinView.alpha = 0;
        _redCoinView.alpha = 0;
        _figure2.alpha = 0;
        _figure3.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _blueCoinView.center = CGPointMake(300, 130);
            _figure1.center = CGPointMake(300, 130);
            _blueCoinView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                CABasicAnimation* rotationAnimation;
                rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 2 * 0.3 ];
                rotationAnimation.duration = 0.3;
                rotationAnimation.cumulative = YES;
                rotationAnimation.repeatCount = 2;
                
                [_figure1.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
            } completion:^(BOOL finished) {

                [UIView animateWithDuration:0.5 animations:^{
                    _figure1.size = CGSizeMake(100, 150);
                    _figure1.image = [UIImage imageNamed:@"p2"];
                } completion:^(BOOL finished) {
//                    _chestClaimView.alpha = 0;
                }];
            }];
        }];
    }];
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
