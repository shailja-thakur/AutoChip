module top_module(
        input x,
        input y,
        output z);

    // Declare internal wire
    wire a;

    // Implement the boolean function
    assign a = x ^ y;
    assign z = a & x;

endmodule
