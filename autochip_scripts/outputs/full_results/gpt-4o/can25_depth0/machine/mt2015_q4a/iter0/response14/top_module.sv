module top_module(
    input x,
    input y,
    output z);

    wire xor_xy;

    // Perform XOR operation between x and y
    assign xor_xy = x ^ y;

    // Perform AND operation between xor_xy and x
    assign z = xor_xy & x;

endmodule
