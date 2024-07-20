module top_module (
	input clk,
	input x,
	output z
);
	// Declare the D flip-flops
	reg dff1, dff2, dff3;
	
	// Declare the intermediate signals
	wire xor_out, and_out, or_out;
	
	// Assign the inputs of the D flip-flops
	always @(posedge clk) begin
		dff1 <= x ^ dff1;
		dff2 <= ~dff2 & x;
		dff3 <= ~dff3 | x;
	end
	
	// Connect the flip-flop outputs to the intermediate gates
	assign xor_out = x ^ dff1;
	assign and_out = ~dff2;
	assign or_out = ~dff3;
	
	// Compute the final output Z
	assign z = ~(xor_out ^ and_out ^ or_out);
	
endmodule
