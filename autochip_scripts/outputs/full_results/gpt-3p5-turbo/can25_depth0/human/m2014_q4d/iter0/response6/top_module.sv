module top_module (
	input clk,
	input in,
	output logic out
);
	// D flip-flop
	logic dff;
	
	// XOR gate
	logic xor_res;
	
	always @(posedge clk) begin
		dff <= xor_res;
		out <= dff;
	end
	
	assign xor_res = in ^ out;
	
endmodule
