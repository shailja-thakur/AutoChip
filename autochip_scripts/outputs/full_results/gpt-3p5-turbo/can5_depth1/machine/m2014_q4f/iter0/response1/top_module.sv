module top_module (
    input in1,
    input in2,
    output logic out
);

    // assign out as the logical AND of in1 and the logical NOT of in2
    assign out = in1 & !in2;

endmodule
