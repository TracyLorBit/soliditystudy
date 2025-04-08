// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Proposal {
        string name;
        uint256 voteCount;
    }
    
    address public chairperson;
    mapping(address => bool) public voters;
    mapping(address => bool) public hasVoted;
    Proposal[] public proposals;
    
    event VoteCast(address voter, uint256 proposal);
    event VoterRegistered(address voter);
    
    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson can perform this action");
        _;
    }
    
    modifier onlyVoter() {
        require(voters[msg.sender], "You are not registered to vote");
        _;
    }
    
    constructor(string[] memory _proposalNames) {
        chairperson = msg.sender;
        voters[chairperson] = true;
        
        for (uint256 i = 0; i < _proposalNames.length; i++) {
            proposals.push(Proposal({
                name: _proposalNames[i],
                voteCount: 0
            }));
        }
    }
    
    function registerVoter(address _voter) public onlyChairperson {
        require(!voters[_voter], "Voter already registered");
        voters[_voter] = true;
        emit VoterRegistered(_voter);
    }
    
    function vote(uint256 _proposalIndex) public onlyVoter {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_proposalIndex < proposals.length, "Invalid proposal");
        
        hasVoted[msg.sender] = true;
        proposals[_proposalIndex].voteCount += 1;
        
        emit VoteCast(msg.sender, _proposalIndex);
    }
    
    function getWinner() public view returns (string memory winnerName, uint256 winnerVoteCount) {
        uint256 winningVoteCount = 0;
        uint256 winningProposal = 0;
        
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposal = i;
            }
        }
        
        return (proposals[winningProposal].name, winningVoteCount);
    }
    
    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }
    
    function getProposal(uint256 _index) public view returns (string memory name, uint256 voteCount) {
        require(_index < proposals.length, "Invalid proposal index");
        return (proposals[_index].name, proposals[_index].voteCount);
    }
}