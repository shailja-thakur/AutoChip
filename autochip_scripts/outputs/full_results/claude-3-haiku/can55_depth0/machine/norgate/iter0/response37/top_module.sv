module top_module(
    input a, 
    input b,
    output out
);

    wire or_out;

    assign or_out = a | b;
    assign out = ~or_out;

endmodule
