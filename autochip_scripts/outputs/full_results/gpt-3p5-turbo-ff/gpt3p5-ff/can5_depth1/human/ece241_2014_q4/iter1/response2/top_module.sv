module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] flip_flop_output;

always @(posedge clk) begin
	flip_flop_output <= {flip_flop_output[1:0], x};
end

assign z = ~(flip_flop_output[0] ^ flip_flop_output[1]) ^ ~(flip_flop_output[1] & flip_flop_output[2]);
endmodule
