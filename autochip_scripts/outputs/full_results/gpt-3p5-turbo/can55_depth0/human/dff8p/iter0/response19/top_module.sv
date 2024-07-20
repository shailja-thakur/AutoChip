module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

reg [7:0] dff [7:0];

always @(negedge clk or posedge reset)
    if (reset)
        for (int i=0; i<8; i=i+1)
            dff[i] <= 8'b00110100;
    else
        for (int i=0; i<8; i=i+1)
            dff[i] <= d[i];

always @(posedge clk or posedge reset)
    if (reset)
        q <= 8'b00110100;
    else
        q <= dff[7];

endmodule
