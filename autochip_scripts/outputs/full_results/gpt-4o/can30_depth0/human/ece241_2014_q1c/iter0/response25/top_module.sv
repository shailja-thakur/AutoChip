module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum_ext; // This wire will store the 9-bit extended sum

    assign sum_ext = {a[7], a} + {b[7], b}; // Extend both numbers to 9 bits
    assign s = sum_ext[7:0]; // The result is the lower 8 bits of the sum
    assign overflow = (sum_ext[8] != sum_ext[7]); // Overflow occurs if the carry into the sign bit is different from the carry out

endmodule
