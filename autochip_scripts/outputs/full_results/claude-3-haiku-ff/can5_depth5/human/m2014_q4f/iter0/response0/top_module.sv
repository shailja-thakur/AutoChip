module top_module (
    input in1,
    input in2,
    output logic out
);

    // The 'in2' input has a bubble, which indicates an inverted input. 
    // We can implement this using the NOT operator '~' on the 'in2' input.
    assign out = in1 & ~in2;

endmodule
