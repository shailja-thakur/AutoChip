module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);

    // Concatenation
    wire [7:0] concatenation = {a[0], b[0], c[0], d[0], e[0], f[0], 2'b11};

    // Assign to outputs
    assign w = concatenation;
    assign x = concatenation;
    assign y = concatenation;
    assign z = concatenation;

endmodule
