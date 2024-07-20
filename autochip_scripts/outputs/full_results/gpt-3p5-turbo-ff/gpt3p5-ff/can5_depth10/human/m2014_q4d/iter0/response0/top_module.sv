module top_module (
	input clk,
	input in,
	output logic out
);

	reg out;
	wire xor_input;

	assign xor_input = in ^ out;

	always @(posedge clk) begin
		out <= xor_input;
	end

endmodule
