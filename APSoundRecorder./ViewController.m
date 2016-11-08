//
//  ViewController.m
//  APSoundRecorder.
//
//  Created by Mac on 15/08/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    recordSetting = [[NSMutableDictionary alloc] init];
    
    self.sliderPlay.hidden = YES;
    self.sliderPlay.userInteractionEnabled = NO;
    
    self.sliderPlay.minimumValue = 0;
    
    self.sliderPlay.value= 0;
    
    [self.sliderPlay setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    
    [self updateDurationSlider];
    
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    
    NSError *error;
    
    audioRecorder = [[AVAudioRecorder alloc]initWithURL:[self getRecordUrl] settings:recordSetting error:&error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    else{
        NSLog(@"Audio recorder Successfully created");

    }
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
   
    NSString *currentTime = [dateFormatter stringFromDate:today];
  
  
    NSLog(@"%@",currentTime);
    _labelTime.text = currentTime;
    
    _labelQuality.text = [NSString stringWithFormat:@"Best Quality"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)getRecordPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"record.caf"];
    
}

-(NSURL *)getRecordUrl {
    
    NSLog(@"%@",[self getRecordPath]);
    
    return [NSURL URLWithString:[self getRecordPath]];
}

-(void)updateDurationSlider {
    
    if (self.sliderPlay.value == audioPlayer.duration) {
        
        timer = nil;
    }
    
    self.sliderPlay.value = audioPlayer.currentTime;
    
    NSTimeInterval currentTime = self->audioPlayer.currentTime;
    
    NSInteger minutes = floor(currentTime/60);
    NSInteger seconds = trunc(currentTime - minutes * 60);
    
    // update your UI with currentTime;
    startDuration = [NSString stringWithFormat:@"%ld:%02ld", (long)minutes, (long)seconds];
    
    self.labelTimeDuration.text= startDuration;
    
//    NSTimeInterval durationTime = self->audioPlayer.duration;
//    
//    NSInteger minutesDuration = floor(durationTime/60);
//    NSInteger secondsDuration = trunc(durationTime - minutes * 60);
//    
//    // update your UI with duration time;
//    self.endTime.text = [NSString stringWithFormat:@"%ld:%2ld", (long)minutesDuration, (long)secondsDuration];
}

-(void)startTimer {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDurationSlider) userInfo:nil repeats:YES];
    
    
}



- (IBAction)buttonRecordStop:(id)sender {
    
    UIButton *button = sender;
    
    if (button.tag == 101) {
        
        [audioRecorder record];
        
        [self startTimer];
        
        _labelStatus.text = [NSString stringWithFormat:@"RECORDING..."];
        _labelRecordPlay.text = [NSString stringWithFormat:@"PRESS TO STOP"];
        
        button.tag = 102;
    }
    else if (button.tag== 102){
        
        [audioRecorder stop];
        
        [self startTimer];

        button.tag = 101;
        
        _labelStatus.text = [NSString stringWithFormat:@"START"];
        _labelRecordPlay.text = [NSString stringWithFormat:@"PRESS TO RECORD"];
        

        
    }
    
}

- (IBAction)buttonPlay:(id)sender {
   
    UIButton *button = sender;
    
    self.sliderPlay.hidden = NO;

    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[self getRecordUrl] error:&error];
    
    if (error) {
        
        //
    }
    else{
        
        if (button.tag == 101) {
            [audioPlayer play];
            
            [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];

            button.tag = 102;
            
            

        }
        else if (button.tag == 102){
            [audioPlayer pause];
            button.tag = 101;
            [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
           

        }
        
    }
    
    
    
}
@end
