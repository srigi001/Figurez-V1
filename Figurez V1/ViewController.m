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
@property (weak, nonatomic) IBOutlet UIImageView *blueCoin;
@property (weak, nonatomic) IBOutlet UIView *blueProgress;
@property (weak, nonatomic) IBOutlet UIView *yellowPreogress;
@property (weak, nonatomic) IBOutlet UIImageView *yellowCoin;

@property (assign) BOOL withEvolution;
@property (assign) BOOL withRankUp;
@property (weak, nonatomic) IBOutlet UIButton *collectButtonAfterEvolution;
@property (weak, nonatomic) IBOutlet UILabel *rankUpCongrats;
@property (weak, nonatomic) IBOutlet UIButton *rankUpCollectButton;
;

@property (assign) CGRect chestInitialFrame;
@property (assign) CGRect figure2InitialFrame;
@property (assign) CGRect coinsInitialFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _figurezView.layer.cornerRadius = 10.0;
    _figuresButtonLeadingConstraint.constant = -_figurezButton.frame.size.width;
    [self resetToLobby];
    _figure2InitialFrame = _figure2.frame;
    _chestInitialFrame = _chestImage.frame;
    _coinsInitialFrame = _coinsView.frame;
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
- (IBAction)didPressChestShortcut:(id)sender {
    _withEvolution = true;
    _withRankUp = true;
    
    [self setInitialSateCollect];
    [self showChestWithAnimation];
}

- (void)runGameChestFlowWithEvolution:(BOOL)withEvolution andRankUp:(BOOL)withRankUp {
    
    _withEvolution = withEvolution;
    _withRankUp = withRankUp;
    
    [self setInitialSateCollect];
    [self showChestWithAnimation];
    
    _gameCheatView.hidden = true;
}

- (void)setInitialSateCollect{
    _chestImage.alpha = 1;
    _chestClaimView.alpha = 1;
    _chestClaimView.hidden = false;
    _blueCoinView.alpha = 0;
    _yellowCoinView.alpha = 0;
    _collectButton.alpha = 0;
    _figure1.alpha = 0;
    _figure2.alpha = 0;
    _figure2.frame = _figure2InitialFrame;
    _chestImage.centerY = _chestImage.height*4;
    _blueProgress.alpha = 0;
    _yellowPreogress.alpha = 0;
    _coinsView.alpha = 0;
    _coinsView.frame = _coinsInitialFrame;
    _blueProgress.width = 20;
    _yellowPreogress.width = 20;
    _collectButtonAfterEvolution.alpha = 0;
    _rankUpCongrats.alpha = 0;
    _rankUpCollectButton.alpha = 0;
}

- (void)showChestWithAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        _chestImage.frame = _chestInitialFrame;
        _congratsLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _collectButton.alpha = 1;
        }];
    }];

}

- (IBAction)didPressCollectButton:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{
        
        //hide collect button
        _collectButton.alpha = 0;
        
        //show coints and badjes
        _coinsView.alpha = 1;
        _yellowCoinView.alpha = 1;
        _blueCoinView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [self moveCointToWallet];
    }];
}

-(void)moveCointToWallet{
    sleep(0.8);
    [UIView animateWithDuration:0.8 animations:^{
        
        //move coins to wallet
        _coinsView.center = CGPointMake(135, -150);
        
    } completion:^(BOOL finished) {
        [self moveBlueCoins:3];
        
        _figure1.alpha = 1;
        _blueProgress.alpha = 1;
        
    }];
}

-(void)moveBlueCoins:(int)numOfCoins{
    UIImageView *movingCoin = [[UIImageView alloc] initWithImage:_blueCoin.image];
    [_chestClaimView addSubview:movingCoin];
    movingCoin.frame= _blueCoin.frame;
    movingCoin.center = _blueCoinView.center;
    
    if (numOfCoins == 1)
    {
        _blueCoinView.alpha = 0;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        movingCoin.center = _figure1.center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _blueProgress.width = _blueProgress.width + 10;
        }];
        
        [movingCoin removeFromSuperview];
        
        if (numOfCoins > 1)
        {
            [self moveBlueCoins:numOfCoins-1];
        }
        else
        {
            _yellowPreogress.alpha = 1;
            _yellowCoinView.alpha = 1;
            _figure2.alpha = 1;
            [self moveYellowCoins:2];
        }
    }];
}

-(void)moveYellowCoins:(int)numOfCoins{
    UIImageView *movingCoin = [[UIImageView alloc] initWithImage:_yellowCoin.image];
    [_chestClaimView addSubview:movingCoin];
    movingCoin.frame= _yellowCoin.frame;
    movingCoin.center = _yellowCoinView.center;
    
    if (numOfCoins == 1)
    {
        _yellowCoinView.alpha = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        movingCoin.center = _figure2.center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _yellowPreogress.width = _yellowPreogress.width + 10;
        } completion:^(BOOL finished) {
            [movingCoin removeFromSuperview];
            
            if (numOfCoins > 1)
            {
                [self moveYellowCoins:numOfCoins-1];
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    _yellowCoinView.alpha = 0;
                } completion:^(BOOL finished) {
                    if(_withEvolution)
                    {
                        [self evolutionFlow];
                    }
                    else
                    {
                        [self regularFlowFinish];
                    }
                }];
            }
        }];
    }];
}

-(void)regularFlowFinish{
    sleep(2);
    [UIView animateWithDuration:0.8 animations:^{
        _chestClaimView.alpha = 0;
    }];
}

-(void)evolutionFlow{
    
    _yellowPreogress.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        _chestImage.alpha = 0;
        _figure1.alpha = 0;
        _blueProgress.alpha = 0;
        _figure2.width = _figure2.width * 2;
        _figure2.height = _figure2.height * 1.3;
        _figure2.top = _congratsLabel.bottom + 15;
        _figure2.centerX = _chestClaimView.centerX;
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 2 * 0.3 ];
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 2;
        [_figure2.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        } completion:^(BOOL finished) {
            _coinsView.centerY = _figure2.centerY;
            _coinsView.right = _figure2.left - 30;
            
            [UIView animateWithDuration:0.8 animations:^{
                _collectButtonAfterEvolution.alpha = 1;
                _coinsView.alpha = 1;
            }];
    }];
}
- (IBAction)didPressCollectAfterEvolution:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{
        
        //move coins to wallet
        _coinsView.center = CGPointMake(135, -150);
        _collectButtonAfterEvolution.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (_withRankUp)
        {
            [self withRankUpFlow];
        }
        else
        {
            sleep(1);
            
            [UIView animateWithDuration:0.8 animations:^{
                
                _chestClaimView.alpha = 0;
            }];
        }
    }];

}

-(void)withRankUpFlow{
    [UIView animateWithDuration:0.8 animations:^{
        _figure2.alpha = 0;
    } completion:^(BOOL finished) {
        _coinsView.centerX = _rankUpCongrats.centerX;
        _coinsView.top = _rankUpCongrats.bottom + 10;
        [UIView animateWithDuration:0.8 animations:^{
            _rankUpCongrats.alpha = 1;
            _coinsView.alpha = 1;
            _rankUpCollectButton.alpha = 1;
        }];
    }];
}
- (IBAction)didPressCollectAfterRankUp:(id)sender {
    [UIView animateWithDuration:0.8 animations:^{
        
        //move coins to wallet
        _coinsView.center = CGPointMake(135, -150);
        _rankUpCollectButton.alpha = 0;
    } completion:^(BOOL finished) {
        sleep(1);
        [UIView animateWithDuration:0.8 animations:^{
            
            _chestClaimView.alpha = 0;
        }];
    }];

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
