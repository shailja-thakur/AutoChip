module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals for D flip-flops
	reg dff1, dff2, dff3;

	// Internal wires for gates
	wire xor_out, and_out, or_out;
	
	// XOR gate computation: X xor DFF1_out
	assign xor_out = x ^ dff1;
	
	// AND gate computation: X and not(DFF2_out)
	assign and_out = x & ~dff2;
	
	// OR gate computation: X or not(DFF3_out)
	assign or_out = x | ~dff3;
	
	// D flip-flops: Update on clock edge
	always @(posedge clk) begin
	    dff1 <= xor_out;
	    dff2 <= and_out;
	    dff3 <= or_out;
	end
	
	// XNOR gate computation: XNOR of the three flip-flop outputs
	assign z = ~(dff1 ^ dff2 ^ dff3);

endmodule
