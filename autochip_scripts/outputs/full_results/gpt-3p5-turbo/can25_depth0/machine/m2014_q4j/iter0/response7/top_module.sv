module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    assign sum[0] = x[0] + y[0]; // least significant bit of sum
    assign sum[1] = x[1] + y[1] + (sum[0] >> 1);
    assign sum[2] = x[2] + y[2] + (sum[1] >> 1);
    assign sum[3] = x[3] + y[3] + (sum[2] >> 1);
    assign sum[4] = (sum[3] >> 1); // most significant bit of sum (carry bit)

endmodule
