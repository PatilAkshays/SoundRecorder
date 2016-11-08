//
//  ViewController.h
//  APSoundRecorder.
//
//  Created by Mac on 15/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController
{
    
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *audioRecorder;
    NSMutableDictionary *recordSetting;
    
    NSTimer *timer;
    NSString *startDuration;

}


@property (strong, nonatomic) IBOutlet UISlider *sliderPlay;

@property (strong, nonatomic) IBOutlet UILabel *labelStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeDuration;
@property (strong, nonatomic) IBOutlet UILabel *labelRecordPlay;
@property (strong, nonatomic) IBOutlet UILabel *labelData;
@property (strong, nonatomic) IBOutlet UILabel *labelTime;
@property (strong, nonatomic) IBOutlet UILabel *labelQuality;

- (IBAction)buttonRecordStop:(id)sender;

- (IBAction)buttonPlay:(id)sender;

@end

