pragma solidity ^0.4.20;

contract Trivia {

    string ques;
    string a1;
    string a2;
    string a3;
    address owner;
    uint question_time;
    uint player_count = 0;
    uint winner_count = 0;
    player[] players;
    address[] player_addrs;
    address[] correctAddrs;
    bool gameDone;

    mapping (address => player) player_map;



    struct player{
        uint choice;
        address player_address;
    }

    constructor (string ques1, string ans1, string ans2, string ans3, uint time) public {
        ques = ques1;
        a1 = ans1;
        a2 = ans2;
        a3 = ans3;

        gameDone = false;
        owner = msg.sender;
        question_time = time;
    }

    function getQuestion() public view returns(string, string, string, string){
        return (ques,a1,a2,a3);
    }

    function getWinners() public view returns(address){
        if(winner_count == 1){
            return correctAddrs[0];
        }

    }

    function endGame(uint correct_answer) public {
        require(msg.sender == owner);
        require(player_count > 0);
        require(correct_answer > 0 && correct_answer < 4);
        for(uint i = 0; i < player_count; i++) {
            if(player_map[player_addrs[i]].choice == correct_answer) {
                correctAddrs.push(player_map[player_addrs[i]].player_address);
               // correctAddrs.push(players[i].player_address);
                winner_count++;
            }
        }

        gameDone = true;

    }




    function makeChoice(uint8 choice) public {

        require(owner != msg.sender);
        require(choice > 0 && choice < 4);
        player newPlayer;
        newPlayer.choice = choice;
        newPlayer.player_address = msg.sender;
        player_map[msg.sender] = newPlayer;
        player_addrs.push(msg.sender);
        player_count++;
    }
}
