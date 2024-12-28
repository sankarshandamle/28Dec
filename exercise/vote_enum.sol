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

    // Constructor to initialize the contract in the NotStarted phase
    constructor() {
        currentPhase = VotingPhase.NotStarted;
    }

    // Function to move to the next phase
    function nextPhase() public {
        require(currentPhase != VotingPhase.Ended, "Already in the final phase");
        currentPhase = VotingPhase(uint8(currentPhase) + 1);
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
        require(candidates.length > 0, "No candidates registered");

        string memory winner = candidates[0];
        uint256 highestVotes = votes[winner];

        for (uint256 i = 1; i < candidates.length; i++) {
            if (votes[candidates[i]] > highestVotes) {
                winner = candidates[i];
                highestVotes = votes[candidates[i]];
            }
        }

        return winner;
    }
}
