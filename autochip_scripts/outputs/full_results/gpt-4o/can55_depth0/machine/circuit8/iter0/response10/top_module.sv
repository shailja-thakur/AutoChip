module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// Always block triggered on the negative edge of clock signal
	always @(negedge clock) begin
		q <= a; // Assigning the current value of 'a' to 'q'
	end

	// Always block triggered on any change of 'a'
	always @(a or posedge clock) begin
		if (clock) begin
			p <= a; // Assigning the current value of 'a' to 'p' if clock is high
		end
	end

endmodule
