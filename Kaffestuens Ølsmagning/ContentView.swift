//
//  ContentView.swift
//  Kaffestuens Ølsmagning
//
//  Created by Mads Frandsen on 02/04/2020.
//  Copyright © 2020 Mads Frandsen. All rights reserved.
//

import SwiftUI

struct Beer {
    var name: String
    var imageName: String
    var description: String
    var abv: String
    var style: String
}

let beers = [Beer(name: "Octopils",
     imageName: "Octopils",
     description: "Octopils is an Italian pilsner, dry-hopped with Hallertau Tradition and Saphir hops from our favorite German hop farm. The cold-fermenting lager yeast provides a perfectly clean and neutral palette for the German malts and hops to shine, delivering delicate notes of toasted bread and mild citrus fruit. The moderate bitterness and low ABV provide a refreshing balance which makes it all too easy to go back for a second pint.",
     abv: "5.1%",
     style: "Italian Pilsner"),
Beer(name: "Golden Glow",
     imageName: "GoldenGlow",
     description: "Golden Glow is a Session IPA, double dry-hopped with El Dorado and Citra. It has a fruity aroma with notes of pineapple and stone fruit, combined with a soft mouthfeel and balanced bitterness.",
     abv: "4.6%",
     style: "Session IPA"),
Beer(name: "Hindbærsnitte",
imageName: "Hindbaersnitter",
description: "Consisting of pastry strips filled with raspberry preserves or raspberry jam, it is traditionally eaten as a lunch or dinner dessert, but it can also be served at tea time. It should be made a day or so before it is planned to serve, because the icing must be hard before the torte is cut. It is also known as Alexander Torte or Aleksander Torte (Latvian: Aleksandra kūka, Aleksandra torte), which is a dessert that was conceived to commemorate a visit of Tsar Alexander III in Riga. Today, Riga is the capital of Latvia.",
abv: "0.0%",
style: "Pastry"),
Beer(name: "Shoulders of Giants",
     imageName: "ShouldersOfGiants",
     description: "A tribute to the old school of American IPA brewers who paved the way for the Hop Revolution. It's crystal clear in the glass, has a lovely refreshing bitterness and a bold, classic hop profile with Chinook, Simcoe, Amarillo and Columbus.",
     abv: "6.3%",
     style: "West Coast IPA"),
Beer(name: "Metamorphosis",
     imageName: "Metamorphosis",
     description: "Metamorphosis is an oatmeal stout, infused with the most aromatic coffee beans we could get our hands on. It has a rich aroma of roasted malts, cacao, and coffee, with a smooth, creamy mouthfeel and balanced bitterness.",
     abv: "6.2%",
     style: "Coffee Stout")]

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            MasterView().navigationBarTitle(Text("Oversigt"))
            StartView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
            .accentColor(colorScheme == .dark ? .white : .black)
    }
}

struct MasterView: View {
    @State var ratings = Dictionary<String, Int>()
    
    var body: some View {
        List {
            ForEach(beers, id: \.name) { beer in
                NavigationLink(
                    destination: DetailView(selectedBeer: beer, rating: Binding<Int>(
                        get: { self.ratings[beer.name] ?? 0 },
                        set: { self.ratings[beer.name] = $0})
                    )) {
                    Image(beer.imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40, alignment: .center)
                        .padding()
                    
                    Text(beer.name).font(.headline)
                }
            }
        }
    }
}

struct DetailView: View {
    var selectedBeer: Beer?
    @Binding var rating: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

        Group {
            if selectedBeer != nil {
                ScrollView {
                    VStack {
                ZStack(alignment: .bottom) {
                        Image(selectedBeer!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: UIScreen.main.bounds.height / 1.75, alignment: .center)
                            .clipped()
                    
                    VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .extraLight))
                    .edgesIgnoringSafeArea(.all)
                        .frame(height: 65)
                    
                    Picker(selection: $rating, label: Text("Rating")) {
                        ForEach(0 ..< 6) { index in
                            Text("\(index)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: 500)
                    .padding()
                }
                
                HStack {
                    Text(selectedBeer!.abv).font(.largeTitle).padding()
                    Text(selectedBeer!.style).font(.headline).padding()
                }
                        Text(selectedBeer!.description).font(.body).padding()
                    }.navigationBarTitle(Text(selectedBeer!.name))
                }
            } else {

                VStack {
                    Text("Velkommen til!")
                }.navigationBarTitle(Text("Velkommen"))
            }
        }
    }
}

struct StartView: View {
    var body: some View {

        Group {
            Text("Motherfucking start page!").font(.largeTitle)
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
