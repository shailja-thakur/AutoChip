module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum_extended; // 9-bit wide to accommodate carry out

    assign sum_extended = {1'b0, a} + {1'b0, b}; // Extend inputs to 9 bits and add
    assign s = sum_extended[7:0];  // Assign the lower 8 bits to s
    assign overflow = (a[7] == b[7]) && (a[7] != sum_extended[7]); // Check for overflow condition

endmodule
