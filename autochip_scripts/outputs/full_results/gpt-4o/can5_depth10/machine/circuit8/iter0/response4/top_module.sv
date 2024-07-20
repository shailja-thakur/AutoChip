module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// Always block triggered on negative edge of the clock
	always @(negedge clock) begin
		q <= a;  // Assign the current value of 'a' to 'q'
	end
	
	// Always block triggered on any change of the input signal 'a'
	always @(a or posedge clock) begin
		if (clock) begin
			p <= a;  // Assign the current value of 'a' to 'p' if the clock signal is high
		end
	end
	
endmodule
