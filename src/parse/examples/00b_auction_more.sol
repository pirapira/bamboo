contract auction
	(address _beneficiary
	,uint _bidding_time
	,bool[address] _bids
	,uint _highest_bid)
{
	case (bool bid())
	{
		if (now > _bidding_time)
			return (false) then auction_done(_beneficiary, _bids, _highest_bid);
		if (value(msg) < _highest_bid)
			abort;
		bid new_bid =
			new bid(sender(msg), value(msg), this) along value(msg)
				 reentrance { abort; }; // failure throws.
_bids[address(new_bid)] = true;
		return (true) then
			auction(_beneficiary, _bidding_time, _bids, value(msg));
	}
	case (uint highest_bid())
	{
		return (_highest_bid) then
			auction(_beneficiary, _bidding_time, _bids, _highest_bid);
	}
	case (uint bidding_time())
	{
		return (_bidding_time) then
			auction(_beneficiary, _bidding_time, _bids, _highest_bid);
	}
	default
	{
		abort; // cancels the call.
	}

// When the control reaches the end of a contract block,
// it causes an abort.
}
