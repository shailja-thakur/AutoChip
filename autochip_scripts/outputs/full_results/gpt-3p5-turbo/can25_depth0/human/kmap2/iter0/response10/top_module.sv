module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implement the circuit using logic gates

wire w1 , w2 , w3;
not U1 ( .a(c) , .out(w1) );
not U2 ( .a(d) , .out(w2) );
and U3 ( .a(a) , .b(w2) , .out(w3) );
and U4 ( .a(w3) , .b(w1) , .out(out) );
assign out = w3 & w1;
endmodule
