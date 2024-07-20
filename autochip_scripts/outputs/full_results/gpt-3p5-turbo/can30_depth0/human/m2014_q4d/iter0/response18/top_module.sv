module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic flop_output;

xor2 xor_gate (
	.ina(in),
	.inb(out),
	.out(xor_output)
);

positive_edge_trigger_flop flop (
	.clk(clk),
	.d(xor_output),
	.q(flop_output)
);

assign out = flop_output;

endmodule
module xor2 (
	input ina,
	input inb,
	output out
);

assign out = ina ^ inb;

endmodule
module positive_edge_trigger_flop (
	input clk,
	input d,
	output reg q
);

always @(posedge clk)
	q <= d;

endmodule
