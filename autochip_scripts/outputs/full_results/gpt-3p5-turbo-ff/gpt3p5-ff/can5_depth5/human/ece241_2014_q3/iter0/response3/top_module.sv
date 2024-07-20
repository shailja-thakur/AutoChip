module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
    wire not_c, not_d;
    wire w1, w2;
    wire x, y, z;
    
    // Implementing NOT gate 1
    notGate ng1 (
        .in(c),
        .out(not_c)
    );
    
    // Implementing NOT gate 2
    notGate ng2 (
        .in(d),
        .out(not_d)
    );
    
    // Implementing AND gate 1
    andGate2 and1 (
        .in1(c),
        .in2(not_d),
        .out(w1)
    );
    
    // Implementing AND gate 2
    andGate2 and2 (
        .in1(not_c),
        .in2(w1),
        .out(w2)
    );
    
    // Implementing OR gate 1
    orGate2 or1 (
        .in1(not_c),
        .in2(d),
        .out(x)
    );
    
    // Implementing OR gate 2
    orGate2 or2 (
        .in1(c),
        .in2(not_d),
        .out(y)
    );
    
    // Implementing AND gate 3
    andGate2 and3 (
        .in1(x),
        .in2(y),
        .out(z)
    );
    
    // Implementing 4-to-1 multiplexer
    mux4to1 mux (
        .a(a),
		.b(b),
		.c(z),
		.d(w2),
		.s(mux_in)
    );
    
endmodule
module notGate (
	input in,
	output out
);
    assign out = ~in;
endmodule
module andGate2 (
	input in1,
	input in2,
	output out
);
    assign out = in1 & in2;
endmodule
module orGate2 (
	input in1,
	input in2,
	output out
);
    assign out = in1 | in2;
endmodule
module mux4to1 (
    input [1:0] a,
    input [1:0] b,
    input c,
    input d,
    input [1:0] s,
    output out
);
    assign out = s[1] ? (s[0] ? d : c) : (s[0] ? b : a);
endmodule
