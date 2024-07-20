module top_module(
    input x,
    input y,
    output z);
	
    wire a, b;

    xor_gate U1(.a(x), .b(y), .z(a));
    xor_gate U2(.a(y), .b(x), .z(b));
    xor_gate U3(.a(a), .b(b), .z(z));
	
endmodule
