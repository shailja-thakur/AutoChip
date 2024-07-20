module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire c1, c2, c3, c4; // Internal carry wires

    // Full adders
    assign sum[0] = x[0] ^ y[0],
           c1 = x[0] & y[0];

    assign sum[1] = x[1] ^ y[1] ^ c1,
           c2 = (x[1] & y[1]) | (x[1] & c1) | (y[1] & c1);

    assign sum[2] = x[2] ^ y[2] ^ c2,
           c3 = (x[2] & y[2]) | (x[2] & c2) | (y[2] & c2);

    assign sum[3] = x[3] ^ y[3] ^ c3,
           c4 = (x[3] & y[3]) | (x[3] & c3) | (y[3] & c3);

    assign sum[4] = c4; // Overflow bit
    
endmodule
