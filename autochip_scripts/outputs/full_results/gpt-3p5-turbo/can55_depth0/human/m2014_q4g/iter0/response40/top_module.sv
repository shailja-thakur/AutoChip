module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    /* XNOR gate instantiation */
    xnor_gate u1 (.a(in1), .b(in2), .xnor_out(xnor_out));
    
    /* XOR gate instantiation */
    xor_gate u2 (.a(xnor_out), .b(in3), .xor_out(out));

    /* Internal wires */
    logic xnor_out;

endmodule
module xnor_gate (
    input a,
    input b,
    output logic xnor_out
);
    assign xnor_out = ~(a ^ b);
endmodule
module xor_gate (
    input a,
    input b,
    output logic xor_out
);
    assign xor_out = a ^ b;
endmodule
