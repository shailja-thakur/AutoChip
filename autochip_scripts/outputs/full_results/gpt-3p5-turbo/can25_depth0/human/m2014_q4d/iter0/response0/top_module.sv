module top_module (
	input clk,
	input in,
	output logic out
);
	logic xor_output;
	
	always_ff @(posedge clk) begin
		xor_output <= in ^ out;
		out <= xor_output;
	end
endmodule
