module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// Triggered on the negative edge of the clock signal
	always @(negedge clock) begin
		q <= a;
	end

	// Triggered on any change of the input signal 'a'
	always @(a or posedge clock) begin
		if (clock) begin
			p <= a;
		end
	end

endmodule
