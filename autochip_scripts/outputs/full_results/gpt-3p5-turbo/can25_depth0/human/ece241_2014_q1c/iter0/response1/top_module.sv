module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Declare internal signals
	reg [8:0] sum;
	reg carry_out;
	
	// Assign the sum and carry_out signals
	always @(*) begin
		{carry_out, sum} = a + b;
	end
	
	// Assign the output signals
	assign s = sum[7:0];
	assign overflow = carry_out;
	
endmodule
