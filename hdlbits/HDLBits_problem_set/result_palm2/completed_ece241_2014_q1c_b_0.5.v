module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] s;
    reg overflow;

    // Add a and b, and assign the result to s.
    assign s = a + b;

    // Check if the carry-out of bit 7 is set. If it is, then an overflow has occurred.
    assign overflow = (s[7] & (a[7] | b[7]));

endmodule