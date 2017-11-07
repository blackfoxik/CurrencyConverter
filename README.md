# CurrencyConverter
- application was implemented with MVP pattern(it was not necessary for current version, but it is better for testing and in case of future growth it will allow us to avoid Massive View Controller).
- Modules communicate by protocols, dependency injections by setters and constructors. 
- One Storyboard(with base for expand). UI built by Interface builder, constraints by Autolayout.
- No segues. 
- Rates data provider module can be replaced by another one - we need only conform to protocol. 
- Assembling Model-Presenter-View is in ViewController - it is violates the MVP in which ViewController as a View, and should be moved to router(but I did not make it in time). 
- Unit testing only for transport protocol and model (also I was short in time). 
- I can not add UDID testing devices because I have not enrolled to Apple Development program. (only free)
