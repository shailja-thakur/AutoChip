module top_module (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output       overflow
);

    // Perform the addition
    wire [8:0] sum = {1'b0, a} + {1'b0, b};

    // Assign the 8-bit sum to the output s
    assign s = sum[7:0];

    // Check for overflow
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
