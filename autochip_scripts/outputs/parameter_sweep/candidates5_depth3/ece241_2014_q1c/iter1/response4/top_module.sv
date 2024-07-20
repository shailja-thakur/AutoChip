module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s, // Added 'reg' keyword
    output reg overflow // Added 'reg' keyword
);

    // Adder to compute the sum
    // Use a + b as operands
    // Result stored in s
    // Overflow flag set based on MSB carry out
    always @(a, b) begin // Added sensitivity list
        s <= a + b; // Used non-blocking assignment
        overflow <= (a[7] & b[7]) | (s[7] & (~a[7]) & (~b[7]));
    end

endmodule
