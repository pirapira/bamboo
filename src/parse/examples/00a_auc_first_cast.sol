

contract auction
  (address _beneficiary
  ,uint _bidding_time
,bool[address] _bids
	,uint _highest_bid)
{
   default
   {
if (now > _bidding_time)
return (false) then auction_done(_beneficiary, _bids, _highest_bid);
if (value(msg) < _highest_bid)
			abort;
bid new_bid =
new bid(sender(msg), value(msg), this) along value(msg)
 reentrance { abort; }; // failure throws.
     _bids[sender(msg)] = true;
     return (true) then
         auction(_beneficiary, _biddingTime, _bids, value(msg));
   }
}
