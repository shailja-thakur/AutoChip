module top_module (
    input in1,
    input in2, 
    input in3,
    output logic out
);

    logic xnor_out;

    xnor xnor_inst (
        .a(in1),
        .b(in2),
        .y(xnor_out)
    );

    xor xor_inst (
        .a(xnor_out),
        .b(in3),
        .y(out)
    );

endmodule
