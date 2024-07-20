module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Two-input XNOR gate
    wire xnor_out;
    xnor #(2) xnor_gate(
        .a(in1),
        .b(in2),
        .out(xnor_out)
    );
    
    // Two-input XOR gate
    xor #(2) xor_gate(
        .a(xnor_out),
        .b(in3),
        .out(out)
    );

endmodule
