module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    
    wire [8:0] sum;  // 9-bit wire to accommodate the overflow

    assign sum = {1'b0, a} + {1'b0, b};  // Include a leading zero to prevent overflow in the addition
    assign s = sum[7:0];                 // Assign the 8 least significant bits to s
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);  // Check for overflow
    
endmodule
