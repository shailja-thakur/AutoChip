module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] s;

assign sum[0] = carry[0];
assign sum[1:4] = s;

full_adder FA0(.a(x[0]), .b(y[0]), .c(carry[0]), .s(s[0]), .co(carry[1]));
full_adder FA1(.a(x[1]), .b(y[1]), .c(carry[1]), .s(s[1]), .co(carry[2]));
full_adder FA2(.a(x[2]), .b(y[2]), .c(carry[2]), .s(s[2]), .co(carry[3]));
full_adder FA3(.a(x[3]), .b(y[3]), .c(carry[3]), .s(s[3]), .co(carry[4]));

endmodule
module full_adder (
	input a,
	input b,
	input c,
	output s,
	output co
);

assign s = a ^ b ^ c;
assign co = (a & b) | (b & c) | (c & a);

endmodule
