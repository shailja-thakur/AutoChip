module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_output;
	logic prev_xor_output;
	
	always @(posedge clk) begin
		prev_xor_output <= xor_output;
		out <= prev_xor_output;
	end
	
	assign xor_output = in ^ out;
	
endmodule
