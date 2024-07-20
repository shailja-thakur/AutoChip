module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Declare internal wire signals
    wire and_result;
    wire or_result;
    wire xor_result;

    // And gate instantiation
    assign and_result = &in;

    // Or gate instantiation
    assign or_result = |in;

    // Xor gate instantiation
    assign xor_result = ^in;

    // Output assignments
    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;
    
endmodule
