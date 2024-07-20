module top_module(
    input a, 
    input b,
    output out
);

    // Internal wire to hold the OR logic result
    wire or_result;

    // OR gate
    assign or_result = a | b;

    // Inverter
    assign out = ~or_result;

endmodule
