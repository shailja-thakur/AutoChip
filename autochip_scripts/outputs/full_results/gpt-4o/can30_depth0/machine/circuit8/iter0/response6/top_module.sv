module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// First always block triggered on the negative edge of the clock
	always @ (negedge clock) begin
		q <= a;
	end

	// Second always block triggered on any change of the input signal a
	always @ (a) begin
		if (clock) begin
			p <= a;
		end
	end

endmodule
