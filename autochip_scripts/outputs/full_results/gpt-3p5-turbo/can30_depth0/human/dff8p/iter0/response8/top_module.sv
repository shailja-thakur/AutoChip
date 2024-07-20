module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q;
);

reg [7:0] dff [0:7];

always @(posedge clk or negedge reset)
    if (reset == 0)
        for (int i=0; i<8; i=i+1)
            dff[i] <= 8'h34;
    else
        for (int i=0; i<8; i=i+1)
            dff[i] <= d[i];

always @(negedge clk)
    for (int i=0; i<8; i=i+1)
        q[i] <= dff[i];

endmodule
