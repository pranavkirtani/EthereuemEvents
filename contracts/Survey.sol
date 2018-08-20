pragma solidity ^0.4.0;
contract Survey {
    Questionare questionare;
     constructor(){
         questionare=new Questionare();
     }
     function addQuestion(string question,uint question_id) public {
         questionare.addQuestion(question,question_id);
     }
     
     function readQuestions(uint id) view public returns (string) {
         return questionare.readQuestions(id);
     }
     function answerQuestion(uint question_id,string answer) public{
         return questionare.answerQuestion(question_id,answer);
     }
     function readAnswers(uint question_id,uint index) view public returns (string){
         return questionare.readAnswers(question_id,index);
     }
     function answerYesNoQuestion(uint question_id,bool answer) public{
         return questionare.answerYesNoQuestion(question_id,answer);
     }
     function readYesNoAnswers(uint question_id)view public returns (uint,uint){
         return questionare.readYesNoAnswers(question_id);
     }
  
}
contract Questionare{
    
    mapping (uint => address) question_add_map;
    
     function addQuestion(string question,uint question_id) public {
         QuestionCon q;
         address ques_con=new QuestionCon();
         q=QuestionCon(ques_con);
         question_add_map[question_id]=ques_con;
         q.addQuestion(question,question_id);
     }
     
     function readQuestions(uint id) view public returns (string) {
         QuestionCon q;
         address ques_con=question_add_map[id];
         q=QuestionCon(ques_con);
         return q.readQuestions(id);
     }
     function answerQuestion(uint question_id,string answer) public{
         QuestionCon q;
         address ques_con=question_add_map[question_id];
         q=QuestionCon(ques_con);
         return q.answerQuestion(question_id,answer);
     }
     function readAnswers(uint question_id,uint index) view public returns (string){
         QuestionCon q;
         address ques_con=question_add_map[question_id];
         q=QuestionCon(ques_con);
         return q.readAnswers(question_id,index);
     }
     function answerYesNoQuestion(uint question_id,bool answer) public{
         QuestionCon q;
         address ques_con=question_add_map[question_id];
         q=QuestionCon(ques_con);
         return q.answerYesNoQuestion(question_id,answer);
     }
     function readYesNoAnswers(uint question_id)view public returns (uint,uint){
         QuestionCon q;
         address ques_con=question_add_map[question_id];
         q=QuestionCon(ques_con);
         return q.readYesNoAnswers(question_id);
     }
    
}
contract QuestionCon{
        struct Question {
             string question;
             uint question_id;
             uint yes;
             uint no;
         }
         struct YesNo{
             uint yes;
             uint no;
         }
        mapping (uint => Question) question_id_map;
        mapping (uint => string[]) response_id_map;
        mapping (uint => YesNo) yesno_id_map;
        function addQuestion(string question,uint question_id) public {
              
              Question memory question_new;
              question_new=Question(question,question_id,0,0);
              question_id_map[question_id]=question_new;
        }
        function readQuestions(uint question_id) view public returns (string){
                Question memory question;
                question=question_id_map[question_id];
                return question.question;
            }
        function answerQuestion(uint question_id,string answer) public{
                response_id_map[question_id].push(answer);
        }
        function readAnswers(uint question_id,uint index) view public returns (string){

                string [] res=response_id_map[question_id];
                return res[index];
            }
        function answerYesNoQuestion(uint question_id,bool answer) public{
                    if(answer==true){
                        question_id_map[question_id].yes++;
                    }else{
                        question_id_map[question_id].no++;
                    }
                    
                    
                   
            }
        function readYesNoAnswers(uint question_id)view public returns (uint,uint){
                Question memory question;
                question=question_id_map[question_id];
                return (question.yes,question.no);
            
        }
}
