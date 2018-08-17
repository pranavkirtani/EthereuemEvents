pragma solidity ^0.4.17;

contract Inbox{
    
    string public message;
    struct Vote{
        uint count;
    }
    struct Question{
        string question;
        uint question_id;
    }
    event TestValue(uint question_id,uint count);
    mapping (uint248 => Vote) votes;
    Question []questions;
    address[] public instructorAccts;
     constructor() public{
     
        
    }
    function updateVotes(uint248 _question) public{
        Vote memory vote;
        vote=votes[_question];
        vote.count++;
        votes[_question]=vote;
        emit TestValue(_question,vote.count);
    }
    function getVotes(uint248 question) view public returns (uint) {
        Vote memory vote;
        vote=votes[question];
        return vote.count;
    }
    function addQuestion(string _question) public{
        uint length;
        length=questions.length;
        uint new_length;
        new_length=length+1;
        Question memory question;
        question=Question(_question,new_length);
        questions.push(question);
        
    }
    function readQuestions(uint id) view public returns (string){
        Question memory question;
        question=questions[id];
        return question.question;
    }
    
    
    
}