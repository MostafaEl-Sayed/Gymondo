# Gymondo - Gymondo iOS Assessment Task Docs

## Description

Gymondo is a fittness app have a list of exersices that you can be fit in your home

## Run Requirements

- Mac with Apple silicon running macOS Big Sur 11 or later, or an Intel-based Mac running macOS Catalina 10.15.4 or later.
- Xcode 13.0.0 or later
- Swift 5
- iPhone with iOS 14.5 or later

## Package management systems Software

- Swift Package Manager (SPM).

## Services & Tools

- Beter loading experience → [SkeletonView](https://github.com/Juanpe/SkeletonView.git) 
- Image Loading $ caching management -> [Kingfisher](https://github.com/onevcat/Kingfisher.git)

## Project Architecture High Level Layers

## **UI Layer**

- MVVM(Model-View-ViewModel)

## **Core**

- `UseCase` - Hold the  business logic for a specific every use case in your application domain
    - It is referenced by the `Presenter`. The `Presenter` can reference multiple `UseCases` since it’s common to have multiple use cases on the same screen

## Data Layer

- `APIManager` - contains actual implementation of the networking on the app.
- `Internet Manager` - contains the logic of handling the internet failures that used by the `NetworkClient` and implemented based on the `Reachability` class.


## Notes :)
- Project should be covered by unit test, but i didnt have enought time.
- I wrote some hints on the function that needed to be documented. 

## Golden Points 

- i usualy use a template generation for creating the scense module, its something genaric for create needed files (repeated), it helps me with less time implementation for spesific feature
    - *FeatureName*ViewController
    - *FeatureName*ViewModel
- Coloring system that can be injected or initialized by any external tools or integrations
- Usualy i am using a Resolver framework for dependency injection or creating a layer configurator for injecting the scene or component dependancy 


Thank you so much reviewing the Assessment
