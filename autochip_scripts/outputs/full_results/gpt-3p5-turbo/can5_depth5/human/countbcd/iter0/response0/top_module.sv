module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else if (ena[1]) begin
            q[3:0] <= q[3:0] + 4'd1;
        end else if (ena[2]) begin
            q[7:4] <= q[7:4] + 4'd1;
        end else if (ena[3]) begin
            q[11:8] <= q[11:8] + 4'd1;
        end else begin
            q[15:12] <= q[15:12] + 4'd1;
        end
    end
endmodule
