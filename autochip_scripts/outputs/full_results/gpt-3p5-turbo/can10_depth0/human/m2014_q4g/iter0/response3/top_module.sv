module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    xor #(2) xor_gate (
        .a(in1 ^ in2),
        .b(in3),
        .zn(out)
    );

endmodule
