module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for XOR output
	logic xor_out;
	
	// 2-input XOR
	assign xor_out = in ^ out;
	
	// D flip-flop, positive edge triggered
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
