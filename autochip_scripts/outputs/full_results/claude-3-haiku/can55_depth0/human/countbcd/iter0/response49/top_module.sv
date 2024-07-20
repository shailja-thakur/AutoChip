module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

localparam MAX_COUNT = 9999;

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        if (q == MAX_COUNT) begin
            q <= 0;
        end
        else begin
            q <= q + 1;
        end
    end
end

assign ena[1] = (q[3:0] == 9);
assign ena[2] = (q[7:4] == 9);
assign ena[3] = (q[11:8] == 9);

endmodule
