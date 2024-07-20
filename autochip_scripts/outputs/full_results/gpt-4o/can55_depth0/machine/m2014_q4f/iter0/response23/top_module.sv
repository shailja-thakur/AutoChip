module top_module (
    input in1,
    input in2,
    output logic out
);
    // Perform the logical AND operation with in1 and NOT of in2
    assign out = in1 & ~in2;
endmodule
