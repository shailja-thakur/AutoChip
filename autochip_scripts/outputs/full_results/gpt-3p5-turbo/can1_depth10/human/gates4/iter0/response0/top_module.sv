module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

and_gate and1 (
    .in1(in[0]),
    .in2(in[1]),
    .in3(in[2]),
    .in4(in[3]),
    .out(out_and)
);

or_gate or1 (
    .in1(in[0]),
    .in2(in[1]),
    .in3(in[2]),
    .in4(in[3]),
    .out(out_or)
);

xor_gate xor1 (
    .in1(in[0]),
    .in2(in[1]),
    .in3(in[2]),
    .in4(in[3]),
    .out(out_xor)
);

endmodule
module and_gate (
    input in1,
    input in2,
    input in3,
    input in4,
    output out
);
assign out = in1 & in2 & in3 & in4;
endmodule
module or_gate (
    input in1,
    input in2,
    input in3,
    input in4,
    output out
);
assign out = in1 | in2 | in3 | in4;
endmodule
module xor_gate (
    input in1,
    input in2,
    input in3,
    input in4,
    output out
);
assign out = in1 ^ in2 ^ in3 ^ in4;
endmodule
