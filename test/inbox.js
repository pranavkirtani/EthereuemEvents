const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const json = require('./../build/contracts/Inbox.json')
const interface = json['abi'];
const bytecode = json['bytecode'];

beforeEach(async () => {
  accounts = await web3.eth.getAccounts();
  manager = accounts[0];
  console.log("deployed aah")
  inbox = await new web3.eth.Contract(interface)
      .deploy({ data: bytecode })
      .send({ from: manager, gas: '1000000'});
  // console.log("inbox",inbox)
 // console.log("inox.options",inbox.options.address)
 contractAddress=inbox.options.address
});

describe('Inbox Contract', () => {
  
   it('update and get counter', async () => {
     //var eventListner = inbox.at(inbox.options.address);
    var event=inbox.events.allEvents()
    //console.log(event)
    inbox.events.TestValue()
.on("data", function(event) {
  let zombie = event.returnValues;
  // We can access this event's 3 return values on the `event.returnValues` object:
  (async()=>{
  const new_inbox=await new web3.eth.Contract(interface);
  //console.log(new_inbox)
  new_inbox.options.address=inbox.options.address
 // await new_inbox.methods.updateVotes(1).send({from:manager});
  const balance3=await new_inbox.methods.getVotes(1).call({from:manager})
  console.log("balance after event",balance3)

  })()
  
}).on("error", console.error);
    // var testEvent = eventListner.test_value();
    // testEvent.watch(function(error, result){
    //       console.log(error,result)
    //     });
    await inbox.methods.updateVotes(1).send({from:manager});
    const balance=await inbox.methods.getVotes(1).call({from:manager})
    console.log("balance",balance)
    await inbox.methods.updateVotes(1).send({from:manager});
    const balance2=await inbox.methods.getVotes(1).call({from:manager})
    console.log("balance2",balance2)
    // console.log("inbox.events",inbox.events)
     await inbox.methods.addQuestion("hi this is a test").send({from:manager});
    assert.equal(balance,1)
    assert.equal(balance2,2)
   
 
  });
})