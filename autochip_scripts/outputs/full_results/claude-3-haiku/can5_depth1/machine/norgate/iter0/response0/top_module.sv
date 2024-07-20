module top_module(
    input a, 
    input b,
    output out
);

    wire or_out;

    // Implement the OR gate
    assign or_out = a | b;

    // Implement the inverter
    assign out = ~or_out;

endmodule
