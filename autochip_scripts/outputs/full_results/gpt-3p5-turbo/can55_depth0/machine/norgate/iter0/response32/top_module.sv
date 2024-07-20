module top_module(
    input a,
    input b,
    output out
);

    /* the OR gate */
    wire or_output;
    assign or_output = a | b;

    /* the inverter */
    assign out = ~or_output;

endmodule
