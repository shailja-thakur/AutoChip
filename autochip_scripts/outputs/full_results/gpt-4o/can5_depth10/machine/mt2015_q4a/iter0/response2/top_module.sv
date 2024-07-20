module top_module(
    input x,
    input y,
    output z);

    wire xor_result;

    assign xor_result = x ^ y; // XOR operation between x and y
    assign z = xor_result & x; // AND operation between the result of XOR and x

endmodule
