// Generated by Apple Swift version 2.3 (swiftlang-800.10.12 clang-800.0.38)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import GoogleMobileAds;
@import CoreGraphics;
@import CoreData;
@import ObjectiveC;
@import Foundation;
@import StoreKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UITextView;
@class UISwitch;
@class UILabel;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC10SimpleTodo17AddViewController")
@interface AddViewController : UIViewController <UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified textView;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified returnSwitch;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified textCountLabel;
@property (nonatomic) BOOL swtichBool;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)textViewDidChange:(UITextView * _Nonnull)textView;
- (void)textViewDidEndEditing:(UITextView * _Nonnull)textView;
- (IBAction)switchChange:(UISwitch * _Nonnull)sender;
- (void)pushCancelButton;
- (void)pushSaveButton;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class XXXPurchaseManager;
@class SKPaymentTransaction;
@class NSError;

SWIFT_PROTOCOL("_TtP10SimpleTodo26XXXPurchaseManagerDelegate_")
@protocol XXXPurchaseManagerDelegate
@optional
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFinishPurchaseWithTransaction:(SKPaymentTransaction * _Null_unspecified)transaction decisionHandler:(void (^ _Null_unspecified)(BOOL complete))decisionHandler;
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFinishUntreatedPurchaseWithTransaction:(SKPaymentTransaction * _Null_unspecified)transaction decisionHandler:(void (^ _Null_unspecified)(BOOL complete))decisionHandler;
- (void)purchaseManagerDidFinishRestore:(XXXPurchaseManager * _Null_unspecified)purchaseManager;
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFailWithError:(NSError * _Null_unspecified)error;
- (void)purchaseManagerDidDeferred:(XXXPurchaseManager * _Null_unspecified)purchaseManager;
@end

@class UIWindow;
@class NSString;
@class NSNumber;
@class NSUserDefaults;
@class UIApplication;
@class NSObject;
@class NSURL;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

SWIFT_CLASS("_TtC10SimpleTodo11AppDelegate")
@interface AppDelegate : UIResponder <XXXPurchaseManagerDelegate, UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
@property (nonatomic, strong) NSString * _Nullable itemText;
@property (nonatomic, strong) NSNumber * _Nullable displayOrder;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
@property (nonatomic, strong) NSURL * _Nonnull applicationDocumentsDirectory;
@property (nonatomic, strong) NSManagedObjectModel * _Nonnull managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator * _Nonnull persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext * _Nonnull managedObjectContext;
- (void)saveContext;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIColor;
@class UIStoryboard;
@class UIButton;

SWIFT_CLASS("_TtC10SimpleTodo19ColorViewController")
@interface ColorViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified blueButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified deepBlueButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified redButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified greenButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified orangeButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified purpleButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified lightgrayButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified darkgrayButton;
@property (nonatomic, readonly, strong) UIColor * _Nonnull blueColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull deepBlueColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull redColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull greenColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull orangeColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull purpleColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull lightGrayColor;
@property (nonatomic, readonly, strong) UIColor * _Nonnull darkGrayColor;
@property (nonatomic, strong) UIStoryboard * _Nullable colorStoryboard;
@property (nonatomic, strong) UIViewController * _Nullable mainViewController;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)pushBlueButton:(UIButton * _Nonnull)sender;
- (IBAction)pushDeepBlueButton:(UIButton * _Nonnull)sender;
- (IBAction)pushRedButton:(UIButton * _Nonnull)sender;
- (IBAction)pushGreenButton:(UIButton * _Nonnull)sender;
- (IBAction)pushOrangeButton:(UIButton * _Nonnull)sender;
- (IBAction)pushPurpleButton:(UIButton * _Nonnull)sender;
- (IBAction)pushLightgrayButton:(UIButton * _Nonnull)sender;
- (IBAction)pushDarkgrayButton:(UIButton * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC10SimpleTodo18EditViewController")
@interface EditViewController : UIViewController <UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, strong) AppDelegate * _Nonnull appDelegate;
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified textView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified textCountLabel;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)textViewDidChange:(UITextView * _Nonnull)textView;
- (void)textViewDidEndEditing:(UITextView * _Nonnull)textView;
- (void)pushCancelButton;
- (void)pushSaveButton;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSArray;
@class UIPickerView;

SWIFT_CLASS("_TtC10SimpleTodo22FontSizeViewController")
@interface FontSizeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) IBOutlet UIPickerView * _Null_unspecified fontPickerView;
@property (nonatomic, readonly, strong) NSArray * _Nonnull sizeArray;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView * _Nonnull)pickerView;
- (NSInteger)pickerView:(UIPickerView * _Nonnull)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString * _Nullable)pickerView:(UIPickerView * _Nonnull)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView * _Nonnull)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC10SimpleTodo13GadController")
@interface GadController : GADBannerView <GADBannerViewDelegate, GADAdDelegate>
- (GADBannerView * _Nonnull)gadBannerInit:(CGFloat)frameWidth frameHeight:(CGFloat)frameHeight viewController:(UIViewController * _Nonnull)viewController;
- (nonnull instancetype)initWithAdSize:(GADAdSize)adSize origin:(CGPoint)origin OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAdSize:(GADAdSize)adSize OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSEntityDescription;

SWIFT_CLASS("_TtC10SimpleTodo4Item")
@interface Item : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Item (SWIFT_EXTENSION(SimpleTodo))
@property (nonatomic, strong) NSNumber * _Nullable checked;
@property (nonatomic, strong) NSNumber * _Nullable displayOrder;
@property (nonatomic, copy) NSString * _Nullable text;
@end


SWIFT_CLASS("_TtC10SimpleTodo3Log")
@interface Log : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDate;

@interface Log (SWIFT_EXTENSION(SimpleTodo))
@property (nonatomic, copy) NSString * _Nullable text;
@property (nonatomic, strong) NSDate * _Nullable time;
@end

@class NSFetchedResultsController;
@class UITableView;
@class NSIndexPath;
@class UITableViewCell;
@class UIBarButtonItem;
@class UINavigationBar;
@class UIToolbar;
@class UIView;

SWIFT_CLASS("_TtC10SimpleTodo17LogViewController")
@interface LogViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified tableView;
@property (nonatomic, weak) IBOutlet UINavigationBar * _Null_unspecified navigationBar;
@property (nonatomic, weak) IBOutlet UIToolbar * _Null_unspecified btmToolbar;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified popupView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified headerView;
@property (nonatomic, strong) AppDelegate * _Nonnull appDelegate;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified zeroView;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
@property (nonatomic, strong) NSFetchedResultsController * _Nonnull fetchedResultsController;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)controllerDidChangeContent:(NSFetchedResultsController * _Nonnull)controller;
- (void)setNaviToolbarColor;
- (void)showPopMessageView;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didDeselectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (IBAction)pushCloseButton:(UIBarButtonItem * _Nonnull)sender;
- (IBAction)pushSaveButton:(UIBarButtonItem * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILongPressGestureRecognizer;
@class UITableViewRowAction;
@class NSLayoutConstraint;

SWIFT_CLASS("_TtC10SimpleTodo18MainViewController")
@interface MainViewController : UIViewController <GADBannerViewDelegate, GADAdDelegate, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified tableView;
@property (nonatomic, weak) IBOutlet UIToolbar * _Null_unspecified btmToolBar;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified popMessageView;
@property (nonatomic, strong) AppDelegate * _Nonnull appDelegate;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
@property (nonatomic, readonly, strong) GadController * _Nonnull gadController;
@property (nonatomic, strong) GADBannerView * _Nullable bannerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified btmToolBarConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified tableBtmConstraint;
@property (nonatomic, strong) NSFetchedResultsController * _Nonnull fetchedResultsController;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)controllerDidChangeContent:(NSFetchedResultsController * _Nonnull)controller;
- (void)setNaviToolbarColor;
- (NSInteger)setBadgeValue;
- (IBAction)settingButton:(UIBarButtonItem * _Nonnull)sender;
- (void)cellLongPressed:(UILongPressGestureRecognizer * _Nonnull)recognizer;
- (void)showPopMessageView;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didDeselectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)setCheckedValue:(NSNumber * _Nonnull)value indexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSArray<UITableViewRowAction *> * _Nullable)tableView:(UITableView * _Nonnull)tableView editActionsForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView moveRowAtIndexPath:(NSIndexPath * _Nonnull)sourceIndexPath toIndexPath:(NSIndexPath * _Nonnull)destinationIndexPath;
- (void)pushTrashButton;
- (void)pushAddButton;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
- (IBAction)pushMemoButton:(UIBarButtonItem * _Nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIActivityIndicatorView;

SWIFT_CLASS("_TtC10SimpleTodo22PurchaseViewController")
@interface PurchaseViewController : UIViewController <XXXPurchaseManagerDelegate>
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified purchaseButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified restoreButton;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView * _Null_unspecified buttonActivityView;
@property (nonatomic, strong) UIActivityIndicatorView * _Null_unspecified purchaseActivityView;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)buttonStatusChange;
- (IBAction)pushPurchaseButton:(UIButton * _Nonnull)sender;
- (IBAction)pushRestoreButton:(UIButton * _Nonnull)sender;
- (void)startPurchase:(NSString * _Nonnull)productIdentifier;

/// リストア開始
- (void)startRestore;
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFinishPurchaseWithTransaction:(SKPaymentTransaction * _Null_unspecified)transaction decisionHandler:(void (^ _Null_unspecified)(BOOL complete))decisionHandler;
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFinishUntreatedPurchaseWithTransaction:(SKPaymentTransaction * _Null_unspecified)transaction decisionHandler:(void (^ _Null_unspecified)(BOOL complete))decisionHandler;
- (void)purchaseManager:(XXXPurchaseManager * _Null_unspecified)purchaseManager didFailWithError:(NSError * _Null_unspecified)error;
- (void)purchaseManagerDidFinishRestore:(XXXPurchaseManager * _Null_unspecified)purchaseManager;
- (void)purchaseManagerDidDeferred:(XXXPurchaseManager * _Null_unspecified)purchaseManager;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC10SimpleTodo21SettingViewController")
@interface SettingViewController : UITableViewController
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified soundSwitch;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified badgeSwitch;
@property (nonatomic, weak) IBOutlet UISwitch * _Null_unspecified adSwitch;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified fontSizeSubLabel;
@property (nonatomic, readonly, strong) NSUserDefaults * _Nonnull userDefaults;
@property (nonatomic, strong) UIStoryboard * _Nullable settingStoryboard;
@property (nonatomic, strong) UIViewController * _Nullable mainViewController;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (IBAction)adChange:(UISwitch * _Nonnull)sender;
- (IBAction)soundChange:(UISwitch * _Nonnull)sender;
- (IBAction)badgeChange:(UISwitch * _Nonnull)sender;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIView (SWIFT_EXTENSION(SimpleTodo))

/// For typical purpose, use "public func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this
- (void)fadeIn:(NSTimeInterval)duration completed:(void (^ _Nullable)(void))completed;

/// For typical purpose, use "public func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this
- (void)fadeOut:(NSTimeInterval)duration completed:(void (^ _Nullable)(void))completed;
@end

@class SKProduct;
@class SKProductsRequest;
@class SKProductsResponse;
@class SKRequest;

SWIFT_CLASS("_TtC10SimpleTodo17XXXProductManager")
@interface XXXProductManager : NSObject <SKProductsRequestDelegate, SKRequestDelegate>

/// 課金アイテム情報を取得
+ (void)productsWithProductIdentifiers:(NSArray<NSString *> * _Null_unspecified)productIdentifiers completion:(void (^ _Nullable)(NSArray<SKProduct *> * _Null_unspecified, NSError * _Nullable))completion;
- (void)productsRequest:(SKProductsRequest * _Nonnull)request didReceiveResponse:(SKProductsResponse * _Nonnull)response;
- (void)request:(SKRequest * _Nonnull)request didFailWithError:(NSError * _Nonnull)error;
- (void)requestDidFinish:(SKRequest * _Nonnull)request;

/// おまけ 価格情報を抽出
+ (NSString * _Nonnull)priceStringFromProduct:(SKProduct * _Null_unspecified)product;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class SKPaymentQueue;

SWIFT_CLASS("_TtC10SimpleTodo18XXXPurchaseManager")
@interface XXXPurchaseManager : NSObject <SKPaymentTransactionObserver>
@property (nonatomic, strong) id <XXXPurchaseManagerDelegate> _Nullable delegate;

/// シングルトン
+ (XXXPurchaseManager * _Nonnull)sharedManager;

/// 課金開始
- (void)startWithProduct:(SKProduct * _Nonnull)product;

/// リストア開始
- (void)startRestore;
- (void)paymentQueue:(SKPaymentQueue * _Nonnull)queue updatedTransactions:(NSArray<SKPaymentTransaction *> * _Nonnull)transactions;
- (void)paymentQueue:(SKPaymentQueue * _Nonnull)queue restoreCompletedTransactionsFailedWithError:(NSError * _Nonnull)error;
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue * _Nonnull)queue;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


#pragma clang diagnostic pop
