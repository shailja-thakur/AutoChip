module top_module(
    input x,
    input y,
    output z);

    // Intermediate signal for XOR operation
    wire xor_xy;

    // XOR operation between x and y
    assign xor_xy = x ^ y;

    // AND operation between xor_xy and x
    assign z = xor_xy & x;
    
endmodule
