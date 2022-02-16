//
//  ContentView.swift
//  MusicAppJared
//
//  Created by Klaus Unruh on 16.02.22.
//

import SwiftUI

struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
}

struct ContentView: View {
    
    var albums = [Album(name: "Bridge 1", image: "1",
                       songs: [Song(name: "One", time: "1:01"),
                               Song(name: "Two", time: "2:22"),
                               Song(name: "Tree", time: "3:30")]),
                 Album(name: "Apple 2", image: "2",
                       songs: [Song(name: "Four", time: "1:01"),
                               Song(name: "Five", time: "2:22"),
                               Song(name: "Six", time: "3:30")]),
                 Album(name: "City 3", image: "3",
                       songs: [Song(name: "Seven", time: "1:01"),
                               Song(name: "Eight", time: "2:22"),
                               Song(name: "Nine", time: "3:30")]),
                 Album(name: "BMW 4", image: "4",
                       songs: [Song(name: "Ten", time: "1:01"),
                               Song(name: "Eleven", time: "2:22"),
                               Song(name: "Twelf", time: "3:30")]),
                 Album(name: "Nike 5", image: "5",
                       songs: [Song(name: "Thirteen", time: "1:01"),
                               Song(name: "Fourteen", time: "2:22"),
                               Song(name: "Fiveteen", time: "3:30")])]
    
    @State private var currentAlbum : Album?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack {
                        ForEach(self.albums, id: \.self, content: {
                            album in
                            AlbumArt(album: album).onTapGesture {
                                self.currentAlbum = album
                            }
                        })
                    }
                })
                LazyVStack {
                    ForEach((self.currentAlbum?.songs ?? self.albums.first?.songs) ??
                            [Song(name: "One", time: "1:01"),
                                    Song(name: "Two", time: "2:22"),
                                    Song(name: "Tree", time: "3:30")],
                            id: \.self,
                            content: {
                                song in
                        SongCell(song: song)
                    })
                }
            }.navigationTitle("LIVE")
        }
    }
}

struct AlbumArt : View {
    var album : Album
    var body : some View {
        ZStack(alignment: .bottom, content: { // image
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            ZStack { // text over the image
                Blur(style: .dark) // with blur effect
                Text(album.name).foregroundColor(.white)
            }.frame(height: 60, alignment: .center)
        }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell : View {
    var song : Song
    var body : some View {
        HStack {
            ZStack {
                Circle().frame(width: 50, height: 50, alignment: .center).foregroundColor(.blue)
                Circle().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
            }
            Text(song.name).bold()
            Spacer()
            Text(song.time)
        }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongCell(song: Song(name: "Tree", time: "3:30"))
    }
}
