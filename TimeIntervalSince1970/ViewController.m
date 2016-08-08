//
//  ViewController.m
//  TimeIntervalSince1970
//
//  Created by demin on 16/7/4.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) float currentTime;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //用[NSDate date]可以获取系统当前时间
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    //输出格式为：2010-10-27 10:22:13
//    NSLog(@"%@",currentDateStr);
    
    
#warning 取本地时间
//    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval tmp =[date timeIntervalSince1970]*1;
//    NSString *timestamp = [NSString stringWithFormat:@"%lld", (long long)tmp];
//
//    NSLog(@"%f",tmp);
//    NSLog(@"%@",timestamp);
//    1467628198
//    1467628222373
    
//
//    //直接打印时间的时候需要考虑时区问题，用NSDataformater的时候不需要考虑时区
//    NSDate *date = [NSDate date];
//    NSLog(@"%@",date);
    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//    
//    NSLog(@"%@",strDate);
    
    
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
//    
////    [self returnUploadTime:dic];
//    //Tue May 21 10:56:45 +0800 2013
//    NSString *timeStr = [dic objectForKey:@"created_at"];
    
    
    
    
    
    
//    NSString *lastTimeStr = [NSString stringWithFormat:@"%@",@(model.messageTime)];
//     NSTimeInterval late = [lastTimeStr doubleValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //按秒计算
    //获取最近的一次时间距离1970的时间间隔
    NSDate *date1 = [dateFormatter dateFromString:@""];
    NSTimeInterval late = [date1 timeIntervalSince1970]*1;
    
    //获取现在的时间距离1970的时间间隔
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [nowDate timeIntervalSince1970]*1;
    NSLog(@"现在%f",now);
    
    
    NSTimeInterval cha = now-1469522539-2800-660-60;
    
//    //小时
//    int hour = cha/3600;
//    //分
//    int mini = (cha - hour*3600)/60;
//    //秒
//    int second = cha - hour*3600 - mini*60;
//    //小时*3600+分*60+秒
//    
//    NSLog(@"%d %d %d",hour,mini,second);
//    
//    //将时间依照某种格式转成字符串
//    NSString *dateStr = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,mini,second];
//    
//    NSLog(@"%@",dateStr);
    
    self.currentTime = cha;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startCaculateTime) userInfo:nil repeats:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//开始计算时间
- (void)startCaculateTime {
    self.currentTime += 0.01;
    int ss; //秒
    int mm; //分
    int hh; //时
   
    //错误写法，这样写，定时器不会走，失败
//    ss = self.currentTime - (self.currentTime/60)*60;
//    mm = self.currentTime/60 - (self.currentTime/3600)*60;
//    hh = self.currentTime/3600;
    ss = (int)self.currentTime-(((int)self.currentTime)/60)*60;
    mm = ((int)self.currentTime)/60-(((int)self.currentTime)/3600)*60;
    hh =((int)self.currentTime)/3600;
    
    NSString *str = @"";
    if (hh>=1) {
        str = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hh,mm,ss];
    }else {
        str = [NSString stringWithFormat:@"%.2d:%.2d",mm,ss];

    }
    
    
    self.timeLbl.text = str;

}



/*处理返回应该显示的时间*/
- (NSString *) returnUploadTime:(NSDictionary *)dic
{
    //Tue May 21 10:56:45 +0800 2013
    NSString *timeStr = [dic objectForKey:@"created_at"];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"E MMM d HH:mm:SS Z y"];
    NSDate *d=[date dateFromString:timeStr];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        timeString = [NSString stringWithFormat:@"今天 %@",[dateformatter stringFromDate:d]];
    }
    if (cha/86400>1)
    {
        //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YY-MM-dd HH:mm"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:d]];
           }
    return timeString;
}



//转换时间格式
- (NSString *)transDataFomart:(NSString *)time{
    NSLog(@"%@",time);
    //NSDateFormatter  时间格式对象
    NSDateFormatter *lastMatter = [[NSDateFormatter alloc]init];
    //dateFormat 自定义时间格式//设置时间格式
    lastMatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
    
    //dateFromString把一个时间字符串依照某种格式 转成时间对象
    NSDate *lastDate = [lastMatter dateFromString:time];//结束时间
    
    //当前时间  格林尼治时间  相差了8个小时
    NSDate *nowDate = [NSDate date];
    NSLog(@"%@",nowDate);
    //timeIntervalSinceDate两个时间的时间差 单位是秒
    NSTimeInterval inter = [lastDate timeIntervalSinceDate:nowDate];
    NSLog(@"时间差：%f",inter);
    
    //    NSDateFormatter *nowMatter = [[NSDateFormatter alloc]init];
    //    nowMatter.dateFormat = @"HH:mm:ss";
    
    //剩余时间
    //小时
    int hour = inter/3600;
    //分
    int mini = (inter - hour*3600)/60;
    //秒
    int second = inter - hour*3600 - mini*60;
    //小时*3600+分*60+秒
    
    NSLog(@"%d %d %d",hour,mini,second);
    //将时间依照某种格式转成字符串
    NSString *dateStr = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,mini,second];
    
    return dateStr;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
