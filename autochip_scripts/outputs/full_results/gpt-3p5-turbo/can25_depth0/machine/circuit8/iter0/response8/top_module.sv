module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

// Assign q on the negative edge of the clock signal
always @(negedge clock)
begin
	q <= a; // Assign the value of signal a to register q
end

// Assign p if the clock signal is high and there is a change in signal a
always @(posedge clock or a)
begin
	if (clock)
		p <= a; // Assign the value of signal a to register p if clock is high
end

endmodule
