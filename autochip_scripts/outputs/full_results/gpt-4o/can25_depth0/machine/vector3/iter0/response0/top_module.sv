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

    wire [39:0] concatenated;

    // Concatenating the inputs and adding the last 2 bits 2'b11
    assign concatenated = {a, b, c, d, e, f, 2'b11};

    // Splitting the concatenated wire into four 8-bit output ports
    assign w = concatenated[39:32];
    assign x = concatenated[31:24];
    assign y = concatenated[23:16];
    assign z = concatenated[15:8];

endmodule
