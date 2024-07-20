module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s_reg;  // Register for storing the sum
	
	always @(*) begin
		s_reg = a + b;  // Calculate the sum of a and b
	end
	
	assign s = s_reg;  // Assign the value of sum to output s
	
	assign overflow = (a[7] && b[7] && !s_reg[7]) || (!a[7] && !b[7] && s_reg[7]);  // Check for signed overflow
	
endmodule
