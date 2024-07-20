module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] and_outputs;

and u1 (.a, c, .b, d, .z, and_outputs[0]);
and u2 (.a, c, .b, ~d, .z, and_outputs[1]);
and u3 (.a, ~c, .b, ~d, .z, and_outputs[2]);
and u4 (.a, ~c, .b, d, .z, and_outputs[3]);

assign mux_in[0] = ~and_outputs[0];
assign mux_in[1] = and_outputs[1];
assign mux_in[2] = ~and_outputs[2];
assign mux_in[3] = and_outputs[3];

endmodule
