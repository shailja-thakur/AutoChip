module top_module(
    input a, 
    input b,
    output out
);

    wire or_output;

    // Implement the OR gate
    assign or_output = a | b;

    // Implement the inverter
    assign out = ~or_output;

endmodule
