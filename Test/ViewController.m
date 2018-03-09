//
//  ViewController.m
//  Test
//
//  Created by 刘少鹏 on 2017/12/11.
//  Copyright © 2017年 刘少鹏. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"1.jpg"];
    self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.imageView];
    
    //第一种方式:使用UIVisualEffectView
    //样式可以选择
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectV = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectV.alpha = 0.7;
//    effectV.frame = CGRectMake(0, 0, self.view.frame.size.width / 2, self.view.frame.size.height);
//    [self.imageView addSubview:effectV];
    
    
    //第二种方式:使用CoreImage
    //Core Image设置模糊之后会在周围产生白边
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    UIImage *blurImage = [self coreBlueImage:image];
    self.imageView.image = blurImage;

    //返回当前类别下的所有滤镜,更换不同的category会打印不同的滤镜名称
    /*
     CORE_IMAGE_EXPORT NSString * const kCICategoryDistortionEffect;
     CORE_IMAGE_EXPORT NSString * const kCICategoryGeometryAdjustment;
     CORE_IMAGE_EXPORT NSString * const kCICategoryCompositeOperation;
     CORE_IMAGE_EXPORT NSString * const kCICategoryHalftoneEffect;
     CORE_IMAGE_EXPORT NSString * const kCICategoryColorAdjustment;
     CORE_IMAGE_EXPORT NSString * const kCICategoryColorEffect;
     CORE_IMAGE_EXPORT NSString * const kCICategoryTransition;
     CORE_IMAGE_EXPORT NSString * const kCICategoryTileEffect;
     CORE_IMAGE_EXPORT NSString * const kCICategoryGenerator;
     CORE_IMAGE_EXPORT NSString * const kCICategoryReduction NS_AVAILABLE(10_5, 5_0);
     CORE_IMAGE_EXPORT NSString * const kCICategoryGradient;
     CORE_IMAGE_EXPORT NSString * const kCICategoryStylize;
     CORE_IMAGE_EXPORT NSString * const kCICategorySharpen;
     CORE_IMAGE_EXPORT NSString * const kCICategoryBlur;    各种模糊分类
     CORE_IMAGE_EXPORT NSString * const kCICategoryVideo;
     CORE_IMAGE_EXPORT NSString * const kCICategoryStillImage;
     CORE_IMAGE_EXPORT NSString * const kCICategoryInterlaced;
     CORE_IMAGE_EXPORT NSString * const kCICategoryNonSquarePixels;
     CORE_IMAGE_EXPORT NSString * const kCICategoryHighDynamicRange;
     CORE_IMAGE_EXPORT NSString * const kCICategoryBuiltIn;
     CORE_IMAGE_EXPORT NSString * const kCICategoryFilterGenerator NS_AVAILABLE(10_5, 9_0);
     */
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBlur];
    for (NSString *filterName in filters) {
        //我们可以通过filterName创建对应的滤镜对象
        NSLog(@"滤镜名称:%@",filterName);
//        CIFilter *filter = [CIFilter filterWithName:filterName];
//        NSDictionary *attributes = [filter attributes];
//        //获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
//        NSLog(@"filter attributes:%@",attributes);
    }
    
    /*
     kCICategoryBlur分类下所有滤镜名称
     CIBokehBlur
     CIBoxBlur
     CIDepthBlurEffect
     CIDiscBlur
     CIGaussianBlur
     CIMaskedVariableBlur
     CIMedianFilter
     CIMorphologyGradient
     CIMorphologyMaximum
     CIMorphologyMinimum
     CIMotionBlur
     CINoiseReduction
     CIZoomBlur
     */
    

}

- (UIImage *)coreBlueImage:(UIImage *)image {
    //创建输入CIImage对象
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    //创建滤镜(可以更换不同的滤镜,滤镜名称可以从以上代码获取
    CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];
    //设置滤镜属性值为默认值
    [filter setDefaults];
    //设置输入图像
    [filter setValue:inputImage forKey:kCIInputImageKey];
    //获取输出图像
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    //创建CIContex上下文对象
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
