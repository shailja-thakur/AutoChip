module top_module (
	input wire a, 
	input wire b,
	input wire c,
	input wire d,
	output wire out
);
    assign out = (~c & ~d) | (~a & ~c) | (a & b) | (b & ~c & ~d) | (a & ~b & d);
endmodule
