//
//  ContentView.swift
//  BowWow
//
//  Created by Burri, Luke on 2020-11-26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dogImage = UIImage()
    
    //track the people we pull information about
    @State private var people: [Person] = [] //empty array to start
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    //show a new dog
                    fetchMoreCuteness()
                }, label: {
                    Text("More please")
                })
                
                Image(uiImage: dogImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Spacer()
                List(people) { person in Text(person.name)}
            }
            .navigationTitle("bow WOW!")
        }
        .onAppear() {fetchNames()}
    }
    
    func fetchNames() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://api.sheety.co/4552dba5e262c3f1c2b5419dc65ef2e1/peopleInClass/sheet1")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let personData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: personData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedPersonData = try? JSONDecoder().decode(People.self, from: personData) {
                
                print("People data decoded from JSON successfully")
                
                //update the UI on the main thread
                DispatchQueue.main.async {
                    people = decodedPersonData.sheet1
                }
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    // Get a random pooch pic!
    func fetchMoreCuteness() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let doggieData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: doggieData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedDoggieData = try? JSONDecoder().decode(RandomDog.self, from: doggieData) {
                
                print("Doggie data decoded from JSON successfully")
                print("URL is: \(decodedDoggieData.message)")
                
                // Now fetch the image at the address we were given
                fetchImage(from: decodedDoggieData.message)
                
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    // Get a random pooch pic!
    
    // Get the actual image data
    func fetchImage(from address: String) {
        
        // 1. Prepare a URL that points to the image to be loaded
        let url = URL(string: address)!
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let imageData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
           
            // Attempt to create an instance of UIImage using the data from the server
            guard let loadedDog = UIImage(data: imageData) else {
                
                // If we could not load the image from the server, show a default image
                dogImage = UIImage(named: "example")!
                return
            }
            
            // Set the image loaded from the server so that it shows in the user interface
            dogImage = loadedDog
            
        }.resume()
        
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
