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
- (IBAction)moreMedalsTapped:(id)sender;
- (IBAction)gameCheat1:(id)sender;
- (IBAction)gameCheat2:(id)sender;
- (IBAction)gameCheat3:(id)sender;
- (IBAction)gameCheat4:(id)sender;
- (IBAction)chestButtonTapped:(id)sender;
- (IBAction)figurezButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *infoView;
- (IBAction)infoDismissed:(id)sender;
- (IBAction)infoButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *cashierView;
- (IBAction)cashierDismissed:(id)sender;

@property (assign) BOOL menuContainerIsShowing;
@property (weak, nonatomic) IBOutlet UIView *figureCardView;
- (IBAction)figureCardDismissed:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *blueCoinView;
@property (weak, nonatomic) IBOutlet UIView *yellowCoinView;
@property (weak, nonatomic) IBOutlet UIView *coinsView;
@property (weak, nonatomic) IBOutlet UIImageView *chestImage;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIImageView *figure1;
@property (weak, nonatomic) IBOutlet UIImageView *figure2;
@property (weak, nonatomic) IBOutlet UILabel *congratsLabel;

@property (assign) BOOL withEvolution;
@property (assign) BOOL withRankUp;
@property (assign) BOOL lastStepAfterEvolution;
@property (assign) BOOL lastStepAfterLevelUp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _figurezView.layer.cornerRadius = 10.0;
    _figuresButtonLeadingConstraint.constant = -_figurezButton.frame.size.width;
    [self resetToLobby];

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
    _infoView.hidden = YES;
    _cashierView.hidden = YES;
    _figureCardView.hidden = YES;
}

- (void)resetToGame {
    _bgLobby.hidden = YES;
    _bgGame.hidden = NO;
    _figurezView.hidden = YES;
    _gameCheatView.hidden = YES;
    _chestClaimView.hidden = YES;
    _infoView.hidden = YES;
    _cashierView.hidden = YES;
    _figureCardView.hidden = YES;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _figureCardView.hidden = NO;
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

- (IBAction)moreMedalsTapped:(id)sender {
    _cashierView.hidden = NO;
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
    _coinsView.alpha = 0;
    _collectButton.alpha = 0;
    _figure1.alpha = 0;
    _figure2.alpha = 0;
    _chestImage.centerY = 300;
//    _figure1.frame = CGRectMake(189, 218, 68, 75);
//    _figure1.image = [UIImage imageNamed:@"p1"];
//    _blueCoinView.center = CGPointMake(440, 90);
//    _yellowCoinView.center = CGPointMake(440, 130);
//    _redCoinView.center = CGPointMake(440, 170);
    
//    _chestImage.alpha = 1;
//    _chestImage.center = CGPointMake(300, 400);
//    _collectButton.frame= CGRectMake(273, 180, 78, 30);
//    _coinsView.center = CGPointMake(280, 120);
//    _congratsLabel.text = @"Congratulations";
}

- (void)showChestWithAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        _chestImage.centerY = 100;
        _congratsLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _collectButton.alpha = 1;
        }];
    }];

}

- (IBAction)didPressCollectButton:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{
        _collectButton.alpha = 0;
        _coinsView.alpha = 1;
        _yellowCoinView.alpha = 1;
        _blueCoinView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            _coinsView.center = CGPointMake(135, -50);
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)withRankUpFlow{
    _lastStepAfterLevelUp = true;
    [UIView animateWithDuration:0.8 animations:^{
        _figure1.alpha = 0;
    } completion:^(BOOL finished) {
        _congratsLabel.text = @"All your figures are now at rank 2";
        _collectButton.frame= CGRectMake(273, 180, 78, 30);
        _coinsView.center = CGPointMake(310, 130);
        [UIView animateWithDuration:0.8 animations:^{
            _coinsView.alpha = 1;
            _collectButton.alpha = 1;
        } completion:^(BOOL finished) {
        
        }];
    }];
}

-(void)noRankUpFlow{
    [UIView animateWithDuration:0.5 animations:^{
        _chestClaimView.alpha = 0;
    }];
}


-(void)noEvolotion{
    [UIView animateWithDuration:0.5 animations:^{
        _blueCoinView.alpha = 0;
        _yellowCoinView.alpha = 0;
        _figure1.alpha = 0;
        _figure2.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _chestClaimView.alpha = 0;
        }];
    }];
}

-(void)withEvolotion{
    [UIView animateWithDuration:0.5 animations:^{
        _yellowCoinView.alpha = 0;
        _figure2.alpha = 0;
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
                _coinsView.alpha = 0;
                _coinsView.center = CGPointMake(430, 170);
                [UIView animateWithDuration:0.5 animations:^{
                    _figure1.size = CGSizeMake(100, 150);
                    _figure1.image = [UIImage imageNamed:@"p2"];
                    _collectButton.alpha = 1;
                    _collectButton.center = CGPointMake(430, 250);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        _coinsView.alpha = 1;
                    } completion:^(BOOL finished) {
                        _lastStepAfterEvolution = true;
                    }];
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
- (IBAction)infoDismissed:(id)sender {
    _infoView.hidden = YES;
}

- (IBAction)infoButtonTapped:(id)sender {
    [self.view bringSubviewToFront:_infoView];
    _infoView.hidden = NO;
}
- (IBAction)cashierDismissed:(id)sender {
    _cashierView.hidden = YES;
}
- (IBAction)figureCardDismissed:(id)sender {
    _figureCardView.hidden = YES;
}
@end
