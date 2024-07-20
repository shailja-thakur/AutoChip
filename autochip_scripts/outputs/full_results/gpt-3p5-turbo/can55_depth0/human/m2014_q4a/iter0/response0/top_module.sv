module top_module (
	input d,
	input ena,
	output logic q
);

// D latch implementation
always @(posedge ena)
    q <= d;

endmodule
