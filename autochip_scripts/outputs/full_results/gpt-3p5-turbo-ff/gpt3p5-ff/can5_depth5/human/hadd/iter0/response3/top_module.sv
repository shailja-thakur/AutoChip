module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Create internal wires for the intermediate signals
    wire intermediate;

    // Create the logic for the sum and carry-out signals
    assign sum = a ^ b;
    assign cout = a & b;

endmodule
