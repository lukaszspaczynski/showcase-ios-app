Feature: Welcome

    This feature covers all Welcome Page use cases.
  
    Scenario: Switching pages forward
        
        Given User starts the app
        And GetBio use case returns success result
        When User enters Welcome screen
        Then User is on page with WelcomePage1Screen id
        When User taps element with WelcomePage1ButtonNext id
        Then User is on page with WelcomePage2Screen id
        When User taps element with WelcomePage2ButtonNext id
        Then User is on page with WelcomePage3Screen id
    
    Scenario: Switching pages backward
        
        Given User starts the app
        And GetBio use case returns success result
        When User enters WelcomePage3 screen
        Then User is on page with WelcomePage3Screen id
        When User taps element with WelcomePage3ButtonPrev id
        Then User is on page with WelcomePage2Screen id
        When User taps element with WelcomePage2ButtonPrev id
        Then User is on page with WelcomePage1Screen id
        
    Scenario: Looping pages backward
        
        Given User starts the app
        And GetBio use case returns success result
        When User enters Welcome screen
        Then User is on page with WelcomePage1Screen id
        When User swipes right on element with WelcomePage1Screen id
        Then User is on page with WelcomePage3Screen id
        
    Scenario: Looping pages forward
        
        Given User starts the app
        And GetBio use case returns success result
        When User enters WelcomePage3 screen
        Then User is on page with WelcomePage3Screen id
        When User swipes left on element with WelcomePage3Screen id
        Then User is on page with WelcomePage1Screen id
        
    Scenario: Reloading Bio
        
        Given User starts the app
        And GetBio use case returns failure result
        When User enters WelcomePage2 screen
        Then User is on page with WelcomePage2Screen id
        And View with WelcomePage2ErrorView id is shown
        And View with WelcomePage2LoadingView id is hidden
        And View with WelcomePage2BioView id is hidden
        And GetBio use case returns success result
        When User taps element with WelcomePage2ButtonReload id
        Then View with WelcomePage2ErrorView id is hidden
        And View with WelcomePage2LoadingView id is hidden
        And View with WelcomePage2BioView id is shown
