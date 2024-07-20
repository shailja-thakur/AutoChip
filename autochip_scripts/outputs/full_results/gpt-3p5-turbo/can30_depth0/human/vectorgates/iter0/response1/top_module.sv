module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    wire [2:0] a_inv, b_inv;
    assign a_inv = ~a;
    assign b_inv = ~b;

    assign out_or_bitwise = a | b;
    assign out_or_logical = a[2] || a[1] || a[0] || b[2] || b[1] || b[0];
    assign out_not = {b_inv, a_inv};

endmodule
