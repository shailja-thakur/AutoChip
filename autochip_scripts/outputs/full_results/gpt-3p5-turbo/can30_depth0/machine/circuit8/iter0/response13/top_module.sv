module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

// Assigns current value of signal a to register q on negative edge of clock
always @(negedge clock)
	q <= a;

// Assigns current value of signal a to register p if clock is high
always @(a or clock)
	begin
		if (clock)
			p <= a;
	end

endmodule
