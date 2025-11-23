//
//  animeappTests.swift
//  animeappTests
//
//  Created by Vignesh Iyer on 11/20/25.
//

import Foundation
import Testing
@testable import animeapp

struct animeappTests {
    
    struct MockGhibliService: GhibliService {
        
        let mockFilms: [Film]
        let shouldThrowError: Bool
        let fetchDelay: Duration
        
        init(
            mockFilms: [Film],
            shouldThrowError: Bool = false,
            fetchDelay: Duration = .zero
        ) {
            self.mockFilms = mockFilms
            self.shouldThrowError = shouldThrowError
            self.fetchDelay = fetchDelay
        }
        
        func fetchFilms() async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            return mockFilms
        }
        
        func searchFilms(for query: String) async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            if query.isEmpty {
                return []
            }
            
            return mockFilms.filter { film in
                film.title.localizedStandardContains(query)
            }
        }
        
        func fetchPerson(from URLString: String) async throws -> Person {
            return Person(id: "", name: "", gender: "", age: "", eyeColor: "", hairColor: "", films: [], species: "", url: "")
        }
        
    }
    
    let mockFilms = [
        Film(id: "2baf70d1-42bb-4437-b551-e5fed5a87abe", title: "Castle in the Sky", description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa\'s science to make himself ruler of the world.", director: "Hayao Miyazaki", producer: "Isao Takahata", releaseYear: "1986", score: "95", duration: "124", image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg", bannerImage: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg", people: ["https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9", "https://ghibliapi.vercel.app/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01", "https://ghibliapi.vercel.app/people/3bc0b41e-3569-4d20-ae73-2da329bf0786", "https://ghibliapi.vercel.app/people/40c005ce-3725-4f15-8409-3e1b1b14b583", "https://ghibliapi.vercel.app/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0", "https://ghibliapi.vercel.app/people/e08880d0-6938-44f3-b179-81947e7873fc", "https://ghibliapi.vercel.app/people/2a1dad70-802a-459d-8cc2-4ebd8821248b"]),
        Film(id: "12cfb892-aac0-4c5b-94af-521852e46d6a", title: "Grave of the Fireflies", description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.", director: "Isao Takahata", producer: "Toru Hara", releaseYear: "1988", score: "97", duration: "89", image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg", bannerImage: "https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg", people: ["https://ghibliapi.vercel.app/people/"]), animeapp.Film(id: "58611129-2dbc-4a81-a72f-77ddfc1b1b49", title: "My Neighbor Totoro", description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.", director: "Hayao Miyazaki", producer: "Hayao Miyazaki", releaseYear: "1988", score: "93", duration: "86", image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg", bannerImage: "https://image.tmdb.org/t/p/original/etqr6fOOCXQOgwrQXaKwenTSuzx.jpg", people: ["https://ghibliapi.vercel.app/people/986faac6-67e3-4fb8-a9ee-bad077c2e7fe", "https://ghibliapi.vercel.app/people/d5df3c04-f355-4038-833c-83bd3502b6b9", "https://ghibliapi.vercel.app/people/3031caa8-eb1a-41c6-ab93-dd091b541e11", "https://ghibliapi.vercel.app/people/87b68b97-3774-495b-bf80-495a5f3e672d", "https://ghibliapi.vercel.app/people/d39deecb-2bd0-4770-8b45-485f26e1381f", "https://ghibliapi.vercel.app/people/591524bc-04fe-4e60-8d61-2425e42ffb2a", "https://ghibliapi.vercel.app/people/c491755a-407d-4d6e-b58a-240ec78b5061", "https://ghibliapi.vercel.app/people/f467e18e-3694-409f-bdb3-be891ade1106", "https://ghibliapi.vercel.app/people/08ffbce4-7f94-476a-95bc-76d3c3969c19", "https://ghibliapi.vercel.app/people/0f8ef701-b4c7-4f15-bd15-368c7fe38d0a"])
    ]


    @MainActor
    @Test func testInitialState() async throws {
        let service = MockGhibliService(mockFilms: mockFilms)
        let viewModel = SearchFilmsViewModel(service: service)
        
        #expect(viewModel.state.data == nil)
        
        if case .idle = viewModel.state {
            
        } else {
            Issue.record("Initial state should be .idle")
        }
    }
    
    @MainActor
    @Test func testFetchFilms() async throws {
        let service = MockGhibliService(mockFilms: mockFilms)
        let viewModel = SearchFilmsViewModel(service: service)
        
        await viewModel.fetch(for: "Castle")
        
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "Castle in the Sky")
    }

    @MainActor
    @Test func testSearchWithError() async throws {
        let service = MockGhibliService(mockFilms: mockFilms, shouldThrowError: true)
        let viewModel = SearchFilmsViewModel(service: service)
        
        await viewModel.fetch(for: "Castle")
        
        #expect(viewModel.state.error != nil)
    }
    
    @MainActor
    @Test func testCancellationAfterAPICall() async {
        let service = MockGhibliService(mockFilms: mockFilms, fetchDelay: Duration.milliseconds(100))
        let viewModel = SearchFilmsViewModel(service: service)
        
        let task = Task {
            await viewModel.fetch(for: "Cas")
        }
        
        try? await Task.sleep(for: .milliseconds(50))
        task.cancel()
        
        await task.value
        
        #expect(viewModel.state == .idle)
    }
}
