module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// First always block triggered on the negative edge of the clock signal
	always @(negedge clock) begin
		q <= a;
	end

	// Second always block triggered on any change of input signal a
	always @(posedge a or posedge clock) begin
		if (clock) begin
			p <= a;
		end
	end

endmodule
