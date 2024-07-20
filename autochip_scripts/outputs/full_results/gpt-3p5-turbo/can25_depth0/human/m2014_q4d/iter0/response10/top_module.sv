module top_module (
	input clk,
	input in,
	output logic out
);
	// D flip-flop
	reg d_ff;
	
	// XOR gate
	wire xor_out;
	
	// Connect inputs and outputs
	assign xor_out = in ^ out;
	always @(posedge clk)
	begin
		d_ff <= xor_out;
		out <= d_ff;
	end
endmodule
