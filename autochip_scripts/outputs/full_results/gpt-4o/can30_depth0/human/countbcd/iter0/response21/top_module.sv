module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    wire tc0, tc1, tc2, tc3;
    
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9) && ena[1];
    assign ena[3] = (q[11:8] == 4'd9) && ena[2];
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            if (ena[3] && q[15:12] == 4'd9) begin
                q <= 16'd0;
            end else if (ena[2] && q[11:8] == 4'd9) begin
                q[15:12] <= q[15:12] + 1;
                q[11:8] <= 0;
            end else if (ena[1] && q[7:4] == 4'd9) begin
                q[11:8] <= q[11:8] + 1;
                q[7:4] <= 0;
            end else if (q[3:0] == 4'd9) begin
                q[7:4] <= q[7:4] + 1;
                q[3:0] <= 0;
            end else begin
                q[3:0] <= q[3:0] + 1;
            end
        end
    end
endmodule
