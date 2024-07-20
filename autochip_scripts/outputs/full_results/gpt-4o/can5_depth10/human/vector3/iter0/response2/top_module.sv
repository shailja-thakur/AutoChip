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
    wire [31:0] temp;

    assign temp = {a, b, c, d, e, f, 2'b11};

    assign w = temp[31:24];
    assign x = temp[23:16];
    assign y = temp[15:8];
    assign z = temp[7:0];
endmodule
