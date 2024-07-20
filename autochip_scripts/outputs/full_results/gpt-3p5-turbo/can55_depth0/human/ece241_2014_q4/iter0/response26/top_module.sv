module top_module (
	input clk,
	input x,
	output z
);

reg flip_flop_1, flip_flop_2, flip_flop_3;
wire xor_gate, and_gate, or_gate;

assign z = ~(xor_gate ^ and_gate ^ or_gate);

// XOR gate
assign xor_gate = flip_flop_1 ^ flip_flop_1;

// AND gate
assign and_gate = ~flip_flop_2 & flip_flop_2;

// OR gate
assign or_gate = ~flip_flop_3 | flip_flop_3;

// D flip-flops
always @(posedge clk) begin
	flip_flop_1 <= x;
	flip_flop_2 <= ~flip_flop_1;
	flip_flop_3 <= ~flip_flop_2;
end

endmodule
