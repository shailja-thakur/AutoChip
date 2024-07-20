module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // Internal signals to hold the reduction results
    wire and_result;
    wire or_result;
    wire xor_result;

    // Perform reduction AND, OR, and XOR operations
    assign and_result = &in;
    assign or_result = |in;
    assign xor_result = ^in;

    // Assign the results to the output ports
    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;

endmodule
