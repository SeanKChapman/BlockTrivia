# BlockTrivia
A simple trivia game written in Solidity in an afternoon. One of 3 winning projects at GWU's Hackital 2018.

BlockTrivia is a bare-bones Ethereum smart contract that was written at a 6-hour hackathon in Washington, DC. Contestants were challened to write a smart-contract in Solidity that demonstrates Ethereum's decentralized application platform.

#### How does BlockTrivia Work:

**Constructing a question:**
When someone wants to post a trivia question, they create an instance of the smart contract. The constructor takes 4 strings. 1 question and 3 possible answers, as well as a time limit.

```c
    constructor (string ques1, string ans1, string ans2, string ans3, uint time) public {
        ques = ques1;
        a1 = ans1;
        a2 = ans2;
        a3 = ans3;

        gameDone = false;
        owner = msg.sender;
        question_time = time;
    }
```

**The Players:**


Players are represented with structs and have two properties - the player's choice, and the player's address.
`
    struct player{
        uint choice;
        address player_address;
    }
`
</br>

**Submitting a Choice:**
Choices are submitted when users call the makeChoice() function on the smart-contract.

```c
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
```

**Ending the Game**
To end the game, the original creator of the smart-contract calls the endGame() function. This searches through all the submissions and collects the addresses of those who answered correctly.
```c
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
```
