pragma solidity ^0.8.0;

contract Workflow {
    enum State { Created, InProgress, Completed }
    State public currentState;

    modifier onlyInState(State _state) {
        require(currentState == _state, "Invalid state");
        _;
    }

    function start() public onlyInState(State.Created) {
        currentState = State.InProgress;
    }

    function complete() public onlyInState(State.InProgress) {
        currentState = State.Completed;
    }
}
