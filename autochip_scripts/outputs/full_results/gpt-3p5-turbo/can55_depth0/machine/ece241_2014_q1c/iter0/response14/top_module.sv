module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [7:0] sum;

    assign s = sum[7:0];
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

    // Adder
    assign sum = a + b;

endmodule
