module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire signed [7:0] signed_a = a;
    wire signed [7:0] signed_b = b;
    wire signed [7:0] signed_s;

    assign signed_s = signed_a + signed_b;
    assign s = signed_s;

    // Detect signed overflow
    assign overflow = ((a[7] == b[7]) && (s[7] != a[7]));

endmodule
