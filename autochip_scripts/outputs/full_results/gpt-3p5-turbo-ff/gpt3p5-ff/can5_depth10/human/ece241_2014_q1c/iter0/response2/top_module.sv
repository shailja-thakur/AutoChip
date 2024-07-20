module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	reg [7:0] s;             // Register for the sum
	wire overflow;           // Wire for storing overflow flag
	
	assign s = a + b;        // Add a and b
	
	// Detect overflow
	always @(*) begin
		if ((a[7] && b[7] && ~s[7]) || (~a[7] && ~b[7] && s[7]))
			overflow = 1;
		else
			overflow = 0;
	end
	
endmodule
