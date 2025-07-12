## NYTimes Popular Articles

A SwiftUI app that fetches and displays the most popular articles from the New York Times API. The app is built using MVVM, Swift Concurrency and SwiftUI 

---

## Features

- Fetch popular NYT articles
- Filter by period (1, 7, or 30 days)
- Pull-to-refresh and loading indicator
- MVVM Architecture with clean separation
- Codable models and URLSession networking
- Unit tested with mock data
- Code coverage enabled

---

## Requirements

- macOS 12+
- Xcode 14+
- iOS 15+
- NYTimes API Key (can be added in `Configuration.swift`)

---

## How to Run the App
1. Clone the repository from the below url:
    git clone https://github.com/rajaindirajith/NYTimes.git
 
2. Open the project:
 NYTimes.xcodeproj
 
3. Set your NYTimes API key in Configuration.swift: (you can skip this, Current I used my temporary api key, you can run and see the output)
    
    struct Configuration {
        static let api_key = "your-api-key-here"
    }
    
4. Run the Project from the top menu, go to: Product → Run or  ⌘ + R

---

## How to Run the Tests

To run the tests:

1. Open the project in Xcode:  
   `NYTimes.xcodeproj`
2. Select the correct **Scheme**: `NYTimes`
3. From the top menu, go to: Product → Test or  ⌘ + U
4. After tests finish:

- Open **Report Navigator** (⌘ + 9)
- Select the latest report
- Click the **"Coverage"** tab {}
- There you'll see which files and functions are covered.


