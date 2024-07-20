module top_module (
	input clk,
	input in,
	output logic out
);

logic flip_flop_out;

xor gate (
	.in1(in),
	.in2(flip_flop_out),
	.out(out)
);

always_ff @(posedge clk) begin
	flip_flop_out <= in;
end

endmodule
