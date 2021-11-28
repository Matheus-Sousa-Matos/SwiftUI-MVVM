//
//  ProfileViewModel.swift
//  MVVM
//
//  Created by Matheus de Sousa Matos on 28/11/21.
//

import Foundation

//MARK: - VIEWMODEL
class ProfileViewModel: ObservableObject{
    
    //Processed Data --
    //Use @Published for updtate interface 
    @Published var isFollowing = false
    @Published var userFollowers = String()

    var user = User(picture: "Sung Jin", name: "Sung Jin", nick: "@sungjin", followers: 91952)
    
    init(){
        loadFollowers()
    }
    
    
    // The properties of value types cannot be modified within its instance methods by default. Use keyword mutating.
    func loadFollowers(){
        self.userFollowers = customizeNumber(value: user.followers)
    }
    
    //Numerical treatment
    func customizeNumber(value: Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        let shorten = formatter.string(for: value) ?? "0"
        return "\(shorten)K"
    }
    
    func followToogle(){
        self.isFollowing.toggle()
        self.isFollowing ? (self.user.followers += 1) : (self.user.followers -= 1)
        loadFollowers()
    }
    
    /*
    mutating func updateUser(){
        self.user.nick = "@sungJinWoo"
    }
     */
}
