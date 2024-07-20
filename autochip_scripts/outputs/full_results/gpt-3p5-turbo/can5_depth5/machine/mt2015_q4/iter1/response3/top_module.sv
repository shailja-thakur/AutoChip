module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    assign a = x & y;  // Use assign instead of and gate
    assign b = y & x;  // Use assign instead of and gate
    assign z = a & b;  // Use assign instead of and gate

endmodule
