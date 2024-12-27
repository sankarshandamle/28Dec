/*

Objective:
Use `enum` to manage the state of a voting system and complete the contract by filling in the missing logic.

-------

Tasks:
1) Constructor:

Initialize the contract with the phase set to NotStarted.

2) Phase Transition Logic:

Implement the nextPhase function to cycle through the phases in the correct order (NotStarted → Registration → Voting → Ended).

3) Determine the Winner:

Implement the logic to calculate the candidate with the highest votes in getWinner.

-------

Hints:
Use the uint8 representation of enum for transitioning phases (VotingPhase(uint8(currentPhase) + 1)).
Use a loop to find the candidate with the highest votes.
*/



pragma solidity ^0.8.0;

contract VotingSystem {
    // Define an enum for the voting phases
    enum VotingPhase { NotStarted, Registration, Voting, Ended }

    // Current phase of the voting process
    VotingPhase public currentPhase;

    // Mapping to store registered voters
    mapping(address => bool) public registeredVoters;

    // Mapping to store votes
    mapping(string => uint256) public votes;

    // List of candidates
    string[] public candidates;

    // Modifier to ensure actions are performed in the correct phase
    modifier inPhase(VotingPhase phase) {
        require(currentPhase == phase, "Action not allowed in this phase");
        _;
    }

    // TODO: Write a constructor to initialize the contract in the NotStarted phase
    constructor() {
        // Initialize with appropriate phase
    }

    // Function to move to the next phase
    function nextPhase() public {
        // TODO: Implement logic to move to the next phase
    }

    // Register a candidate
    function registerCandidate(string memory _candidate) public inPhase(VotingPhase.Registration) {
        candidates.push(_candidate);
    }

    // Register a voter
    function registerVoter(address _voter) public inPhase(VotingPhase.Registration) {
        registeredVoters[_voter] = true;
    }

    // Vote for a candidate
    function vote(string memory _candidate) public inPhase(VotingPhase.Voting) {
        require(registeredVoters[msg.sender], "Not a registered voter");
        votes[_candidate]++;
    }

    // Get the winner (can only be called after voting ends)
    function getWinner() public view inPhase(VotingPhase.Ended) returns (string memory) {
        // TODO: Implement logic to determine the candidate with the most votes
    }
}
