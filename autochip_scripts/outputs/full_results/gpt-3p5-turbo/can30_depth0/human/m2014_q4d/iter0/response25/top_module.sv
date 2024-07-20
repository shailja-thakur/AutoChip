module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic flip_flop_output;

xor #(2) xor_inst (
	.in1(clk),
	.in2(out),
	.out(xor_output)
);

dff #(1) ff_inst (
	.clk(clk),
	.d(xor_output),
	.q(flip_flop_output)
);

assign out = flip_flop_output;

endmodule
module xor (
	input [1:0] in,
	output xor_output
);

xor xor_inst (
	.in1(in[0]),
	.in2(in[1]),
	.out(xor_output)
);

endmodule
module dff (
	input clk,
	input d,
	output logic q
);

always @(posedge clk) begin
	q <= d;
end

endmodule
