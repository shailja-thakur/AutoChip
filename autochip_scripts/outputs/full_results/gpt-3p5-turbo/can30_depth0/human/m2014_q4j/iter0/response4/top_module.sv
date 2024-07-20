module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] carry;

    assign {carry[3], sum[3:0]} = x + y;  // Perform 4-bit addition

    assign carry[0] = (x[0] & y[0]) | (carry[3] & (x[0] ^ y[0])); // Calculate the carry-out

    assign sum[4] = carry[3]; // Assign the carry-out to the overflow bit

endmodule
