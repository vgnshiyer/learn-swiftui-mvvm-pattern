//
//  SettingsScreen.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    // Wrapper for user data.. writes and reads as updates.. and updates the UI
    @AppStorage(UserDefaultsKeys.appearanceTheme)
    private var appearanceTheme: AppearanceTheme = .system
    
    @AppStorage(UserDefaultsKeys.username)
    private var username: String = ""
    
    @AppStorage(UserDefaultsKeys.itemsPerPage)
    private var itermsPerPage: Int = 20
    
    @AppStorage(UserDefaultsKeys.notificationsEnabled)
    private var notificationsEnabled: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Appearance", selection: $appearanceTheme) {
                        ForEach(AppearanceTheme.allCases) { theme in
                            Text(theme.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Overrides the system appearance.")
                }
                
                Section("Account") {
                    TextField("Usersname", text: $username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
                
                Section("Preferences") {
                    Stepper("Items per page: \(itermsPerPage)", value: $itermsPerPage)
                    Toggle("Enable notifications", isOn: $notificationsEnabled)
                }
                
                Section {
                    Button(role: .destructive) {
                        resetDefaults()
                    } label: {
                        Text("Reset to Defaults")
                    }
                }
            }
        }
    }
    
    private func resetDefaults() {
        appearanceTheme = .system
        username = ""
        itermsPerPage = 20
        notificationsEnabled = true
    }
}

// MARK: data model for appearance
// THIS ENUM REPRESENTS CHOICES
enum AppearanceTheme: String, Identifiable, CaseIterable {
    case system
    case light
    case dark
    var id: Self { return self }
}
/*
 * Enums cannot be changes at runtime..
 * allows fixed set of values (cases)
 * Identifiable is a protocol used by for loops to get id for objects.
 * CaseIterable gives .allCases automatically -> [.system, .light, .dark]
 * String stores enum values as string (e.g. AppearanceTheme.system.rawValue -> "system"
 */


// MARK: helper to save user defaults keys and keep them unique
// THIS ENUM REPRESENTS CONSTANTS
enum UserDefaultsKeys {
    static let appearanceTheme: String = "appearanceTheme"
    static let username = "username"
    static let itemsPerPage: String = "itemsPerPage"
    static let notificationsEnabled = "notificationsEnabled"
}
/*
 Can use struct here instead of enums.
 * but enums act as containers for constants
 * structs have initializers
 */

extension View {
    func setAppearanceTheme() -> some View {
        modifier(AppearanceThemeViewModifier())
    }
}

struct AppearanceThemeViewModifier: ViewModifier {
    
    @AppStorage(UserDefaultsKeys.appearanceTheme)
    private var appearanceTheme: AppearanceTheme = .system
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(scheme())
    }
    
    func scheme() -> ColorScheme? {
        switch appearanceTheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
