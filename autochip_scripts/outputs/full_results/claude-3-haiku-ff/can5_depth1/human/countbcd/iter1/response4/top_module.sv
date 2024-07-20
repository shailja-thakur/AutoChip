module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
        ena <= 3'b0;
    end
    else begin
        q[3:0] <= (q[3:0] == 4'd9) ? 4'd0 : q[3:0] + 1;
        ena[1] <= (q[3:0] == 4'd9);
        q[7:4] <= (q[7:4] == 4'd9 && q[3:0] == 4'd9) ? 4'd0 : (q[3:0] == 4'd9) ? q[7:4] + 1 : q[7:4];
        ena[2] <= (q[7:4] == 4'd9 && q[3:0] == 4'd9);
        q[11:8] <= (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) ? 4'd0 : (q[7:4] == 4'd9 && q[3:0] == 4'd9) ? q[11:8] + 1 : q[11:8];
        ena[3] <= (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9);
        q[15:12] <= (q[15:12] == 4'd9 && q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) ? 4'd0 : (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) ? q[15:12] + 1 : q[15:12];
    end
end

endmodule
