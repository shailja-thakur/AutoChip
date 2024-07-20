module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_output;
	
	assign xor_output = in ^ out;
	
	always_ff @(posedge clk) begin
		out <= xor_output;
	end
	
endmodule
