module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    wire [8:0] sum; // 9-bit wire to hold the sum including carry out

    assign sum = a + b;

    always @(*) begin
        s = sum[7:0]; // Assign the lower 8 bits of the sum to s
        // Check for overflow: If the sign of a and b is same and sign of sum is different
        overflow = (~a[7] & ~b[7] & sum[7]) | (a[7] & b[7] & ~sum[7]);
    end

endmodule
