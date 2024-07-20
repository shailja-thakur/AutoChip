module top_module (
    input in1,
    input in2,
    output logic out
);

// Implementation of the logical AND and logical NOT gate
assign out = in1 && !in2;

endmodule
