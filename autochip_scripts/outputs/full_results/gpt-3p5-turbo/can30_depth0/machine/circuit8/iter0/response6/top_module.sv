module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

// assign q with current value of a on negative edge of clock
always @(negedge clock)
begin
	q <= a;
end

// assign p with current value of a if clock signal is high
always @(a)
begin
	if (clock)
		p <= a;
end

endmodule
