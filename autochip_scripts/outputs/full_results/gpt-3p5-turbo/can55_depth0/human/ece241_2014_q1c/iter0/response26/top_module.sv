module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Declare internal signals
	reg [8:0] sum;
	
	// Perform addition
	always @(*) begin
		sum = a + b;
	end
	
	// Assign output signals
	assign s = sum[7:0];
	assign overflow = sum[8];
endmodule
