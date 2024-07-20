module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [15:0] next_q;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        next_q <= 0;
    end else begin
        next_q <= q + 1;
    end
end

always @* begin
    ena = next_q[15:13];
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
    end else begin
        q <= next_q;
    end
end

endmodule
