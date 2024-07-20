module top_module (
	input [7:0] in,
	output [31:0] out
);
    assign out = {24 {in[7]}, 24 {in[6]}, 24 {in[5]}, 24 {in[4]}, 24 {in[3]}, 24 {in[2]}, 24 {in[1]}, 24 {in[0]},in};
endmodule
