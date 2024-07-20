module top_module (
	input [4:1] x,
	output logic f
);

    // Declare intermediate signals
    logic a, b, c, d;

    // Assigning intermediate signals based on input bits
    assign a = x[1] & x[2];
    assign b = x[3] & x[4];
    assign c = x[1] & x[3];
    assign d = x[2] & x[4];

    // Implementing the function f based on Karnaugh map
    assign f = (~a & b) | (~c & ~d);

endmodule
