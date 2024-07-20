module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] flip_flop;
wire [2:0] flip_flop_complement;
wire z;

assign flip_flop_complement = ~flip_flop;

always @(posedge clk)
begin
	flip_flop[0] <= x ^ flip_flop[0];
	flip_flop[1] <= ~(x & flip_flop[1]);
	flip_flop[2] <= x | flip_flop_complement[2];
end

assign z = ~(flip_flop[0] ^ flip_flop[1] ^ flip_flop_complement[2]);

endmodule
