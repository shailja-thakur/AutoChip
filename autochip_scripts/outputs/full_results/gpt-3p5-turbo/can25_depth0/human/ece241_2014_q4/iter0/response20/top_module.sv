module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] flip_flops;
wire xor_input;
wire and_input;
wire or_input;
wire z_input;

assign xor_input = x ^ flip_flops[0];
assign and_input = ~flip_flops[1];
assign or_input = ~flip_flops[2];

always @(posedge clk) begin
	flip_flops[0] <= xor_input;
	flip_flops[1] <= and_input;
	flip_flops[2] <= or_input;
end

assign z_input = xor_input ^ and_input ^ or_input;

assign z = z_input;

endmodule
