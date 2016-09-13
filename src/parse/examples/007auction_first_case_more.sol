

contract auction
  (address _beneficiary
  ,uint _bidding_time
,bool[address] _bids
	,uint _highest_bid)
{
   default
   {
     _bids[sender(msg)] = true;
     return (true) then
         auction(_beneficiary, _biddingTime, _bids, value(msg));
   }
}
