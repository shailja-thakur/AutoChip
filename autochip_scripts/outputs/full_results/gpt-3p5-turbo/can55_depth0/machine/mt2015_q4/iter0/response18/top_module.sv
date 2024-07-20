module top_module(
    input x,
    input y,
    output z
);
    wire a, b;
    
    xor_gate xor1(.a(x), .b(y), .z(a));
    xor_gate xor2(.a(y), .b(x), .z(b));
    or_gate or1(.a(a), .b(b), .z(z));

endmodule
module xor_gate(
    input a,
    input b,
    output z
);
    assign z = a ^ b;
endmodule
module or_gate(
    input a,
    input b,
    output z
);
    assign z = a | b;
endmodule
