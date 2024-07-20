module top_module (
	input clk,
	input x,
	output z
);

reg x_reg;
reg x_reg_complement;
wire flip_flop_out;
wire flip_flop_out_complement;
wire flip_flop_out_complement_2;
wire flip_flop_out_complement_3;

always @(posedge clk) begin
	x_reg <= x;
	x_reg_complement <= ~x;
end

assign flip_flop_out = x ^ x_reg;
assign flip_flop_out_complement = x & x_reg_complement;
assign flip_flop_out_complement_2 = x | x_reg_complement;
assign flip_flop_out_complement_3 = ~(flip_flop_out ^ flip_flop_out_complement_2);
assign z = flip_flop_out_complement_3;

endmodule
