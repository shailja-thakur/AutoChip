module top_module (
    input in1,
    input in2,
    output logic out
);

    // Use logical operators to define the output signal
    assign out = ~(in1 | in2);

endmodule
