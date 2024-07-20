module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (ena[1]) begin
            q[7:4] <= q[7:4] + 1;
        end else if (ena[2]) begin
            q[11:8] <= q[11:8] + 1;
        end else if (ena[3]) begin
            q[15:12] <= q[15:12] + 1;
        end
        
        if (q[7:4] > 9) begin
            q[7:4] <= 4'b0000;
            q[7:4] <= q[7:4] + 1;
        end
        
        if (q[11:8] > 9) begin
            q[11:8] <= 4'b0000;
            q[11:8] <= q[11:8] + 1;
        end
        
        if (q[15:12] > 9) begin
            q[15:12] <= 4'b0000;
            q[15:12] <= q[15:12] + 1;
        end
    end
endmodule
