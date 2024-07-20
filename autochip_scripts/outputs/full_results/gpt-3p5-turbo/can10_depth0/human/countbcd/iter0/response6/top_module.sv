module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b0;
        end else if (ena[3] == 1) begin
            q <= q + 4'b0001;
        end else if (ena[2] == 1) begin
            q[7:4] <= q[7:4] + 4'b0001;
        end else if (ena[1] == 1) begin
            q[11:8] <= q[11:8] + 4'b0001;
        end endmodule
