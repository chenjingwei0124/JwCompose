# UIAlertViewBlockExtension
UIAlertView category for block expression

## Installation
### Using cocoapods
<code>
pod 'UIAlertViewBlockExtension'
</code>

## Features
- Block expression can be used for handling UIAlertView's clicks.
- Similar with UIAlertController in iOS 8.0
- Automatically, use UIAlertController if it is available (checking via [UIAlertController class])

## Examples
### can add buttons with action of block
```
UIAlertView *alertView = [UIAlertView alertViewWithTitle:@"title" message:@"message"];

[alertView addButtonWithTitle:@"OK" actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
  // do something for OK
}];
  
[alertView addCancelButtonWithTitle:@"Cancel" actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
  // do something for cancel
}];
    
[alertView show];
```

### can be used with convenient method

#### 1 Button - Just Cancel
```
[UIAlertView showWithTitle:@"Title" message:@"message" cancelButtonTitle:@"cancel" action:^{
        NSLog(@"cancel");
    }];
```
#### 2 Buttons - Cancel & OK
```
[UIAlertView showWithTitle:@"Title" message:@"message" cancelButtonTitle:@"cancel" cancelAction:^{
        NSLog(@"cancel");
    } otherButtonTitle:@"OK" otherButtonAction:^{
        NSLog(@"ok");
    }];
```

## Requirements
- iOS version 4.0 or later
