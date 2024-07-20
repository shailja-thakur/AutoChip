module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // temporary wire to hold the intermediate result
    wire temp;

    // Perform the first XOR operation
    assign temp = in1 ^ in2;

    // Perform the NOT operation on temp, then XOR with in3 for final output
    assign out = ~temp ^ in3;

endmodule
