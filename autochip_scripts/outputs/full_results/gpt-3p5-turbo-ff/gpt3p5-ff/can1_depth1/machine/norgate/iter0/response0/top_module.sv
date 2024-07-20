module top_module(
    input a, 
    input b,
    output out
);

    wire or_output;
    assign or_output = a | b;
    assign out = ~or_output;

endmodule
