//
//  UsersViewModelTests.swift
//  FaskeStoreTests
//
//  Created by Eric on 05/01/2026.
//

import Testing
@testable import FakeStore2

@MainActor
struct UsersViewModelTests {

    @Test func testFetchUsersSuccess() async {
        let service = MockUserService()
        let viewModel = UsersViewModel(service: service)

        await viewModel.fetchUsers()

        #expect(viewModel.users == User.mockUsers)
        #expect(viewModel.loadingState == .completed)
    }

    @Test func testFetchUsersEmptyState() async {
        var service = MockUserService()
        service.mockUsers = []
        let viewModel = UsersViewModel(service: service)

        await viewModel.fetchUsers()

        #expect(viewModel.users.isEmpty)
        #expect(viewModel.loadingState == .empty)
    }

    @Test func testFetchUsersFailure() async {
        var service = MockUserService()
        let error = APIError.invalidData
        service.errorToThrow = error
        let viewModel = UsersViewModel(service: service)

        await viewModel.fetchUsers()

        #expect(viewModel.users.isEmpty)
        #expect(viewModel.loadingState == .error(error: error))
    }

    @Test func testRefreshUsersSuccess() async {
        let service = MockUserService()
        let viewModel = UsersViewModel(service: service)

        await viewModel.fetchUsers()

        #expect(viewModel.users.count == User.mockUsers.count)
        #expect(viewModel.loadingState == .completed)
    }

    @Test func testRefreshUsersFailure() async {
        var service = MockUserService()
        let error = APIError.invalidURL
        service.errorToThrow = error

        let viewModel = UsersViewModel(service: service)

        await viewModel.refreshUsers()

        #expect(viewModel.users.isEmpty)
        #expect(viewModel.loadingState == .error(error: error))
    }
}
