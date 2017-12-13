# DynamicFormFactory #

DynamicFormFactory with a single API which takes the below form specification json as input, and launches a new UI element on top of the current one.


### How do I get set up? ###

* Simple implementation
* Add DynamicFormFactory directory's file to project
* Add header include in UIViewConroller
```
#import "DynamicFormFactory.h"
```
* Add protocol delegate to controller interface <DynamicFormFactoryDelegate>
* Add code to UIViewController viewDidLoad method:
```
NSString *jsonStr = @"<DynamicFormFactory formatted json string>";
[[[DynamicFormFactory alloc] init] showDynamicForm:jsonStr showInView:self withDelegate:self];
```
* Add <DynamicFormFactoryDelegate> method to submitted data in json string format:
```
-(void) submittedData:(NSString *)jsonString{
    NSLog(@"%@", jsonString);
}
```
* That's it.

Thanks,