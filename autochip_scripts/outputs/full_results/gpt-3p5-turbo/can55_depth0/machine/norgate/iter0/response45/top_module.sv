module top_module(
	input a, 
	input b,
	output out
);

// OR gate
wire or_gate_output;
or_gate or1(.a(a), .b(b), .out(or_gate_output));

// Inverter
not_gate not1(.in(or_gate_output), .out(out));

endmodule
module or_gate(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module not_gate(
    input in,
    output out
);
    assign out = ~in;
endmodule
