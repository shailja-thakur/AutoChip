module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] flip_flop_output;
wire x_xor_ff;
wire x_nand_ff;
wire x_nor_ff;

xor gate1 (x_xor_ff, x, flip_flop_output[0]);
and gate2 (x_nand_ff, x, ~flip_flop_output[1]);
or gate3 (x_nor_ff, x, ~flip_flop_output[2]);

always @(posedge clk) begin
	flip_flop_output <= {x, flip_flop_output[0:1]};
end

assign z = ~(x_xor_ff ^ flip_flop_output[1]) ^ (x_nand_ff ^ x_nor_ff);
endmodule
