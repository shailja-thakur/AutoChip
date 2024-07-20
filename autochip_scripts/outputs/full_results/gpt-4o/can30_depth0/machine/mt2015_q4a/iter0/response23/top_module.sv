module top_module(
    input x,
    input y,
    output z);
    
    assign z = (x ^ y) & x; // XOR of inputs followed by AND with the first input

endmodule
