module top_module (
	input clk,
	input in,
	output logic out
);

// Declare signals
reg D;

// Instantiate XOR gate
xor gate (
	.in1(in),
	.in2(out),
	.out(D)
);

// Instantiate D flip-flop
always @(posedge clk) begin
	out <= D;
end

endmodule
