module top_module (
	input clk,
	input in,
	output logic out
);

logic q;

xor gate1 (.a(in), .b(out), .o(q));

always_ff @(posedge clk)
    out <= q;

endmodule
