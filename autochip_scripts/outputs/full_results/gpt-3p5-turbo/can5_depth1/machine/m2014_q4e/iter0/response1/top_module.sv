module top_module (
    input in1,
    input in2,
    output logic out
);

    // Combinational logic: out = ~(in1 | in2)
    assign out = ~(in1 | in2);

endmodule
