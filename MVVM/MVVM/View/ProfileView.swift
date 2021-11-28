//
//  ProfileView.swift
//  MVVM
//
//  Created by Matheus de Sousa Matos on 28/11/21.
//

/*Notas de aprendizado:
1 - Operadores ternários são bastante poderosos se usados corretamente.
2 - Source of truth = Verdade absoluta pode ser representado por var com @State @State(Simples) Object (Caso seja de maior complexidade) @Biding (Propagar). Nome -> @( property wrapper.)
    Quanto menos Source of truth melhor. 
3 - OnApper(Aparecer pode ser usado na view toda para updates)
4 - Dividir para consquistar uma das melhores técnicas.
5 - Um model sempre fica com o nome da entidade.
6 - State Object transforma a struct tipo "simples" para uma class tipo mais robusto.
7 - Na viewModel usar o ObservableObject protocol, quando se estiver armazenando valores value type usar @State quando for valores reference type usar @StateObject sempre usando o protocolo.
8 - Usar @Published para atualizar a view.
9 - Usar @EnvironmentObject para que de uma maneira simples propague pela view e suas subview sem ter que passar argumentos assim injetando a model de forma simples.
10 - A injeção de dados pode ser feito na primeira tela do app MVVMApp e depois ser reutilizada aqui mesmo na view usando @EnvironmentObject.
 
 Dicas: Fazer planejamento prévio.
        Implementar tudo no mesmo file para entender sobre o flow depous modularizar.
 
        Métodos de separar pastas:
        View -
            Shared: Views compartilhadas. Ex: FavoriteIconView e  RoundedButtonView.
            Screens: Telas da aplicação com novas telas dentro separado por pastas. Ex:Pasta Profile -> ProfleView e ViewModel.
        Model -
            Data models
        Resources -
            Assets e etc
        
 
       Estudar combine framework...
 */

import SwiftUI

//MARK: - VIEW
struct ProfileView: View {
    //@State var viewModel = ProfileViewModel
    //@StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack{
           ProfileDataView()
           ActionView()
        }
        .animation(.easeOut, value: viewModel.isFollowing)
        //.environmentObject(viewModel)
        //If view apper update user nick
        /*
        .onAppear{
            viewModel.updateUser()
        }
         */
    }
        
}

struct ProfileDataView: View{
    //Propagating Source of truth.
    //@Binding var viewModel: ProfileViewModel
    //@ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View{
        Image(viewModel.user.picture)
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 250)
            .padding(.bottom, 10)
            .clipShape(Circle())
            .shadow(radius: 20)
           
        
        Text(viewModel.user.name)
            .font(.system(size: 50, weight: .bold))
        
        Text(viewModel.user.nick)
            .font(.system(size: 23, weight: .regular))
            .foregroundColor(.gray)
        
        Text(viewModel.userFollowers)
            .font(.system(size: 80, weight: .light))
            .padding(viewModel.isFollowing ? 40: 25)
    }
}

struct ActionView: View{
    //Propagating Source of truth.
    //@Binding var viewModel: ProfileViewModel
    //@ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View{
        VStack{
            //Follow
            Button {
                viewModel.followToogle()
            } label: {
                Label(!viewModel.isFollowing ? "Follow" : "Unfollow", systemImage: "bolt.fill")
                    .font(.title)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(!viewModel.isFollowing ? .blue : .black)
            
            //Send mensagem
            Button {
                
            } label: {
                Label("Send Mensagem", systemImage: "bolt.fill")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(!viewModel.isFollowing)

        }
        .padding(20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}
