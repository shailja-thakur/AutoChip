module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

wire [24:0] not_vec;
wire [24:0] xor_vec;

assign not_vec = { {5{~a}}, {5{~b}}, {5{~c}}, {5{~d}}, {5{~e}} };
assign xor_vec = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

assign out = not_vec ^ xor_vec;

endmodule
