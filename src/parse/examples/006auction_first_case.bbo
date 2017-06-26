

contract auction
  (address _beneficiary
  ,uint _bidding_time
,bool[address] _bids
	,uint _highest_bid)
{
   default
   {
     return (true) then
     auction(_beneficiary, _bidding_time, _bids, value(msg));
   }
}
