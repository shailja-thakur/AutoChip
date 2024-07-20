module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

	// Logic to calculate the output signal using a logical OR operation
	assign out = (~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d);

endmodule
