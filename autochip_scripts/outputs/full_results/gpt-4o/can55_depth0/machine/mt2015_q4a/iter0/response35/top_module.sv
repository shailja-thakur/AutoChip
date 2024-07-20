module top_module(
    input x,
    input y,
    output z);

    // Intermediate signal to hold XOR result
    wire xor_result;

    // Perform XOR operation on inputs x and y
    assign xor_result = x ^ y;

    // Perform AND operation between xor_result and input x to get output z
    assign z = xor_result & x;

endmodule
