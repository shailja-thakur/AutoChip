module top_module (
	input clk,
	input in,
	output logic out
);

	reg out_ff;
	reg xor_out;


	always @(posedge clk) begin
		out_ff <= xor_out;
	end

	assign xor_out = in ^ out_ff;

	assign out = out_ff;

endmodule
