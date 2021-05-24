//
//  View+Extensions.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 10/23/20.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

//struct SearchNavigation<Content: View>: UIViewControllerRepresentable {
//    @Binding var text: String
//    var search: () -> Void
//    var cancel: () -> Void
//    var content: () -> Content
//
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
//        navigationController.navigationBar.prefersLargeTitles = true
//        
//        context.coordinator.searchController.searchBar.delegate = context.coordinator
//        
//        return navigationController
//    }
//    
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
//        context.coordinator.update(content: content())
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(content: content(), searchText: $text, searchAction: search, cancelAction: cancel)
//    }
//    
//    class Coordinator: NSObject, UISearchBarDelegate {
//        @Binding var text: String
//        let rootViewController: UIHostingController<Content>
//        let searchController = UISearchController(searchResultsController: nil)
//        var search: () -> Void
//        var cancel: () -> Void
//        
//        init(content: Content, searchText: Binding<String>, searchAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
//            rootViewController = UIHostingController(rootView: content)
//            searchController.searchBar.autocapitalizationType = .none
//            searchController.obscuresBackgroundDuringPresentation = false
//            rootViewController.navigationItem.searchController = searchController
//            
//            _text = searchText
//            search = searchAction
//            cancel = cancelAction
//        }
//        
//        func update(content: Content) {
//            rootViewController.rootView = content
//            rootViewController.view.setNeedsDisplay()
//        }
//        
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            text = searchText
//        }
//        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            search()
//        }
//        
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            cancel()
//        }
//    }
//    
//}
