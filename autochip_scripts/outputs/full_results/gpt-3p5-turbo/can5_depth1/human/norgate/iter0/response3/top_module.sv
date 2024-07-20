module top_module(
    input a,
    input b,
    output out
);
    // Output is assigned to the NOR of inputs a and b
    assign out = ~(a | b);
endmodule
