# Meal Voucher App
 - Current macOS Version: 13.2 (Ventura) or later
 - Current Xcode Version: 14.2
 - Current iOS Minimum Deployment Target: 16.2
 - Current Swift Version: 5.7

 # Codebase Description
 - *UIKit* as UI framework
 - *MVC* as UI design pattern
 - *Modularized* architecture using _Feature Interface_ concept
 - *Swift Package Manager* as dependency manager

 # Libraries/Frameworks
 - Dependency Injection: [Router Service](https://github.com/rockbruno/RouterService)
 - Image downloader: [Kingfisher](https://github.com/onevcat/Kingfisher)

 # Dependency graph
 ## Main app
 ![Main app](images/dependencies/Main.jpeg)

 ## Meal voucher list 
 *Concrete Module*
 ![Meal Voucher List](images/dependencies/MealVoucherList.jpeg)

 *Interface Module*
 ![Meal Voucher List Interface](images/dependencies/MealVoucherListInterface.jpeg)

 ## Meal voucher detail 
 *Concrete Module*
 ![Meal Voucher Detail](images/dependencies/MealVoucherDetail.jpeg)

 *Interface Module*
 ![Meal Voucher Detail Interface](images/dependencies/MealVoucherDetailInterface.jpeg)