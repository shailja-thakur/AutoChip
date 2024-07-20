module top_module (
	input clk,
	input x,
	output z
);
	// Declare D flip-flop signals
	reg d1, d2, d3;
	
	// Declare intermediate signals
	wire xor_out, and_out, or_out;
	
	// Declare output signal
	assign z = ~xor_out;

	// Connect x to the respective gates
	assign xor_out = x ^ d1;
	assign and_out = ~d2 & x;
	assign or_out = ~d3 | x;
	
	// Connect flip-flop outputs to the XOR gate
	d_ff dff1 (.clk(clk), .d(xor_out), .q(d1));
	d_ff dff2 (.clk(clk), .d(and_out), .q(d2));
	d_ff dff3 (.clk(clk), .d(or_out), .q(d3));

endmodule
module d_ff(
	input clk,
	input d,
	output q
);
	reg q;

	always @(posedge clk)
	begin
		q <= d;
	end

endmodule
