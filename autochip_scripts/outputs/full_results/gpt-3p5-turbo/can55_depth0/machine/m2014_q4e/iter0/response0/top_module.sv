module top_module (
    input in1,
    input in2,
    output logic out
);

    // Implementing the logical OR operation using the | operator
    assign out = ~(in1 | in2);

endmodule
