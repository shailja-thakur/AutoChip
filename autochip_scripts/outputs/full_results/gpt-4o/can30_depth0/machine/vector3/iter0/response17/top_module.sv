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

    wire [35:0] concatenation;

    assign concatenation = {a, b, c, d, e, f, 2'b11};

	assign w = concatenation[35:28];
	assign x = concatenation[27:20];
	assign y = concatenation[19:12];
	assign z = concatenation[11:4];

endmodule
