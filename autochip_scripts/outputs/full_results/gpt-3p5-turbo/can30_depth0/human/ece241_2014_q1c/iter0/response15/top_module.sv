module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal signals
	reg [8:0] s_temp;
	reg overflow_temp;
	
	// Adder logic
	always @(a, b) begin
		s_temp = a + b;
		overflow_temp = (a[7] && b[7] && ~s_temp[7]) || (~a[7] && ~b[7] && s_temp[7]);
	end
	
	// Assign outputs
	assign s = s_temp[7:0];
	assign overflow = overflow_temp;

endmodule
