# Animated Like

Animated Like is a protocol oriented, an ios reusable component written in Swift 5. <br>
This was initially made with an inspiration that, in any ecommerce app, for any product a favourite icon is tapped to add it to favourite, which is simple and plain. So, I thought.... <br/> <br>
How about when a view or product is tapped, a "heart icon" is generated and after generation it flies to a destination view and the destination bounces as completion.


How, I have tried to add other features like:
1. Product 360 view which can be rotated, and the view can auto rotate too.
2. Floating emoji icons like in Instagram live feed.

Currently, the protocols added to assist the view for different functionalities are: <br> <br>


1. Tapable -> Confirming to this protocol, gives a view power to listen to a tap, and has completion handler with optional flyable view. <br> <br>

```
    ///here the nil is given when we do not supply the flyable view by ourself.
     tapableView.tap(with: nil) {
         (flyAbleView) in
         // do necessary thing, what you want to do with this flyable view..
         make it fly or remove it from superview if you dont want it.
    }
```

2. Flyable -> Confirming to this protocol, gives a view power to fly from the source point to destination point. <br> <br>

```
    flyAbleView?.fly(to: destinationView,       
            didReachDestination: {
                // do want you want to do when it reaches the destination.
                /// if destionation view confirms the protocol to bouncable.. make be bounce it??
            })

```

3.  Bouncable -> Confirming to this protocol, gives a view power to bounce from its source rect i.e. scale <br> <br>

```
    yourBouncableView.bounce {
                // do anything after the bounce is completed
                // make be shake the view??
    }
```

4. Shakeable -> Confirming to this protocol, gives a view power to shake in x-axis or y-axis. This can be used for text field validation shake functionality when validation fails. <br> <br>

```
     yourShakeAbleView.shakeAlongXAxis()
     yourShakeAbleView.shakeAlongYAxis()
```

5.  Floatable -> Confirming to this protocol, gives a view power to generate instagram like floating emojis from its source rect. <br> <br>

```
    yourFloatableView.addFloatingView(with:  some_image_here)

```

May be you want to add a floatable image when a button click.. so confirm your  floatableView to Tapable protocol too.

```
    yourFloatableView.tap(with: nil) { _ in
             yourFloatableView.addFloatingView(with:  some_image_here)
        }
```

6. Rotatable -> Confirming to this protocol, gives a view power to rotate i.e have the functionality of showing 360 degrees for a product.

```
    yourRotatableView.images = array_of_images
    yourRotatableView.rotate()
```
### ** Watch the video demo ** <br> <br>
[![Watch the video](https://img.youtube.com/vi/8S3XwQM0r8w/0.jpg)](https://youtu.be/8S3XwQM0r8w)
