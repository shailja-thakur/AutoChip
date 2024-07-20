module top_module(
    input a,
    input b,
    output out
);

    // Define internal wire to hold the result of the AND operation
    wire and_result;

    // Perform the AND operation on the inputs
    assign and_result = a & b;

    // Output the result
    assign out = and_result;

endmodule
