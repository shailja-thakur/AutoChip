module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        q[3:0] <= (q[3:0] == 9) ? 0 : q[3:0] + 1;
        q[7:4] <= (q[3:0] == 9) ? ((q[7:4] == 9) ? 0 : q[7:4] + 1) : q[7:4];
        q[11:8] <= (q[3:0] == 9 && q[7:4] == 9) ? ((q[11:8] == 9) ? 0 : q[11:8] + 1) : q[11:8];
        q[15:12] <= (q[3:0] == 9 && q[7:4] == 9 && q[11:8] == 9) ? ((q[15:12] == 9) ? 0 : q[15:12] + 1) : q[15:12];
    end
end

assign ena[1] = (q[3:0] == 9);
assign ena[2] = (q[3:0] == 9 && q[7:4] == 9);
assign ena[3] = (q[3:0] == 9 && q[7:4] == 9 && q[11:8] == 9);

endmodule
