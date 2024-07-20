module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    xor #(.N(2)) xor_gate (
        .A(in1 ^ in2),
        .B(in3),
        .Z(out)
    );

endmodule
