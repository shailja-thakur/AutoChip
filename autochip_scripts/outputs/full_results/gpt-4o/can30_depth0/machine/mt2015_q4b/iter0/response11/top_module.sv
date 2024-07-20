module top_module(
    input x,
    input y,
    output z);

    assign z = ~(x ^ y); // Z is the negation of XOR of x and y

endmodule
