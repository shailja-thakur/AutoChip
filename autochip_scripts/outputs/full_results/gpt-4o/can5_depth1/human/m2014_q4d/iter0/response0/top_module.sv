module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal wire to connect XOR output to D flip-flop input
	wire xor_output;
	
	// XOR operation
	assign xor_output = in ^ out;
	
	// D flip-flop: positive edge triggered by clk
	always_ff @(posedge clk) begin
		out <= xor_output;
	end

endmodule
