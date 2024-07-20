module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

	// Implement combinational logic
	assign q = (a & b & c) | (b & c & d);

endmodule
