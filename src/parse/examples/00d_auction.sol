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
			auction(_beneficiary, _biddingTime, _bids, value(msg));
	}
	case (uint highest_bid())
	{
		return (_highest_bid) then
			auction(_beneficiary, _biddingTime, _bids, _highest_bid);
	}
	case (uint bidding_time())
	{
		return (_bidding_time) then
			auction(_beneficiary, _biddingTime, _bids, _highest_bid);
	}
	default
	{
		abort; // cancels the call.
	}

// When the control reaches the end of a contract block,
// it causes an abort.
}


contract bid
	(address _bidder
	,uint _value
	,auction _auction) // the compiler is aware that an `auction` account can become an `auction_done` account.
{
	case (bool refund())
	{
		if (sender(msg) != _bidder)
			abort;
		if (_auction.bid_is_highest(_value) reentrance { abort; })
			abort;
		selfdestruct(_bidder);
	}
	case (bool pay_beneficiary())
	{
		if (not _auction.bid_is_highest(_value) reentrance { abort; })
			abort;
		address beneficiary = _auction.beneficiary() reentrance { abort; };
		selfdestruct(_beneficiary);
	}
	default
	{
		abort;
	}
}

contract auction_done(address _beneficiary, bool[address] _bids, uint _highest_bid)
{
	case (bool bid_is_highest(uint _cand))
	{
		if (not _bids[sender(msg)]) abort;
		return (highest_bid == _cand) then auction_done(_beneficiary, _bids, _highest_bid);
	}
	case (address beneficiary())
	{
		if (not _bids[sender(msg)]) abort;
		return (_beneficiary) then auction_done(_beneficiary, _bids, _highest_bid);
	}
	default
	{
		abort;
	}
}
