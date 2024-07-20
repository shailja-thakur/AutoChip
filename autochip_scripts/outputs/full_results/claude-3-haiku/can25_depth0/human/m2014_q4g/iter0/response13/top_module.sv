module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out;

    xnor_gate xnor_inst (
        .a(in1),
        .b(in2),
        .out(xnor_out)
    );

    xor_gate xor_inst (
        .a(xnor_out),
        .b(in3),
        .out(out)
    );

endmodule
module xnor_gate (
    input a,
    input b,
    output logic out
);

    assign out = ~(a ^ b);

endmodule
module xor_gate (
    input a,
    input b,
    output logic out
);

    assign out = a ^ b;

endmodule
