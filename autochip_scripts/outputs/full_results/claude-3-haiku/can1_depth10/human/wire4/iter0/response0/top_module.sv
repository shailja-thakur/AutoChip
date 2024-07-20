module top_module (
    input a,
    input b,
    input c,
    output w,
    output x,
    output y,
    output z
);

    // Connect the inputs to the outputs
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule
