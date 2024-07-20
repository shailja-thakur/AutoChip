module top_module (
	input clk,
	input in,
	output logic out
);

	reg out_ff;

	always @(posedge clk)
	begin
		out_ff <= in ^ out_ff;
	end

	assign out = out_ff;

endmodule
