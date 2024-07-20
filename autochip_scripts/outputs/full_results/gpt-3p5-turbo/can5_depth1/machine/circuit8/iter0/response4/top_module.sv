module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg q;  // Register q
	always @(negedge clock)  // First always block triggered on negative edge of clock
	begin
		q <= a;  // Assign current value of signal a to register q
	end

	reg p;  // Register p
	always @(a)  // Second always block triggered on any change of input signal a
	begin
		if (clock)  // Check if clock signal is high
			p <= a;  // Assign current value of signal a to register p
	end

endmodule
