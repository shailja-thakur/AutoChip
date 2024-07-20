module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    xor #(2) xor_gate (
        .a(in1),
        .b(in2),
        .z(out)
    );

    xnor #(2) xnor_gate (
        .a(xor_gate.z),
        .b(in3),
        .z(xor_gate.a)
    );

endmodule
