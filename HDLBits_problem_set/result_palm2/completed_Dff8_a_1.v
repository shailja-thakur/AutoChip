module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    
    DFF D1 (clk, d[0], q[0]);
    DFF D2 (clk, d[1], q[1]);
    DFF D3 (clk, d[2], q[2]);
    DFF D4 (clk, d[3], q[3]);
    DFF D5 (clk, d[4], q[4]);
    DFF D6 (clk, d[5], q[5]);
    DFF D7 (clk, d[6], q[6]);
    DFF D8 (clk, d[7], q[7]);

endmodule