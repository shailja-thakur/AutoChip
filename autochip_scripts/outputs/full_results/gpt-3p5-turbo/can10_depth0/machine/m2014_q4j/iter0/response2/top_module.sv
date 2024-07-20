module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    assign sum[0] = x[0] + y[0]; // least significant bit of sum
    
    // Carry chain for adding 4-bit numbers
    assign sum[1] = x[1] + y[1] + sum[0];
    assign sum[2] = x[2] + y[2] + sum[1];
    assign sum[3] = x[3] + y[3] + sum[2];
    
    // Most significant bit of sum and carry bit
    assign sum[4] = sum[3];
    
endmodule
