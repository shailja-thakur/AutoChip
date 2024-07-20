module top_module(
    input a,
    input b,
    output out
);

    // Assign the output by applying the NOR operation on inputs a and b
    assign out = ~(a | b);

endmodule
