Feature: Welcome

    This feature covers all Welcome Page use cases.
  
    Scenario: Switching pages forward
        
        Given User starts the app
        And GetBio use case returns success result
        And GetAvatar use case returns success result
        When User enters Welcome screen
        Then User is on page with WelcomeAvatarScreen id
        When User taps element with WelcomeAvatarButtonNext id
        Then User is on page with WelcomeBioScreen id
        When User taps element with WelcomeBioButtonNext id
        Then User is on page with WelcomeSkillsScreen id
    
    Scenario: Switching pages backward
        
        Given User starts the app
        And GetBio use case returns success result
        And GetAvatar use case returns success result
        When User enters WelcomeSkills screen
        Then User is on page with WelcomeSkillsScreen id
        When User taps element with WelcomeSkillsButtonPrev id
        Then User is on page with WelcomeBioScreen id
        When User taps element with WelcomeBioButtonPrev id
        Then User is on page with WelcomeAvatarScreen id
        
    Scenario: Looping pages backward
        
        Given User starts the app
        And GetBio use case returns success result
        And GetAvatar use case returns success result
        When User enters Welcome screen
        Then User is on page with WelcomeAvatarScreen id
        When User swipes right on element with WelcomeAvatarScreen id
        Then User is on page with WelcomeSkillsScreen id
        
    Scenario: Looping pages forward
        
        Given User starts the app
        And GetBio use case returns success result
        And GetAvatar use case returns success result
        When User enters WelcomeSkills screen
        Then User is on page with WelcomeSkillsScreen id
        When User swipes left on element with WelcomeSkillsScreen id
        Then User is on page with WelcomeAvatarScreen id
        
    Scenario: Reloading Bio
        
        Given User starts the app
        And GetBio use case returns failure result
        When User enters WelcomeBio screen
        Then User is on page with WelcomeBioScreen id
        And View with WelcomeBioErrorView id is shown
        And View with WelcomeBioLoadingView id is hidden
        And View with WelcomeBioBioView id is hidden
        And GetBio use case returns success result
        When User taps element with WelcomeBioButtonReload id
        Then View with WelcomeBioErrorView id is hidden
        And View with WelcomeBioLoadingView id is hidden
        And View with WelcomeBioBioView id is shown
        
    Scenario: Reloading Avatar
        
        Given User starts the app
        And GetAvatar use case returns failure result
        When User enters WelcomeAvatar screen
        Then User is on page with WelcomeAvatarScreen id
        And View with WelcomeAvatarErrorView id is shown
        And View with WelcomeAvatarLoadingView id is hidden
        And View with WelcomeAvatarAvatarView id is hidden
        And GetAvatar use case returns success result
        When User taps element with WelcomeAvatarButtonReload id
        Then View with WelcomeAvatarErrorView id is hidden
        And View with WelcomeAvatarLoadingView id is hidden
        And View with WelcomeAvatarBioView id is shown
