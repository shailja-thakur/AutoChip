module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

reg [7:0] q_delay;
reg [7:0] q_temp;
reg reset_dff;

initial
begin
    q = 8'd34;
    q_delay = 8'd34;
    q_temp = 8'd34;
    reset_dff = 1'b0;
end

always @(posedge clk)
begin
    reset_dff <= reset;
    if (reset_dff)
        q_temp <= 8'd34;
    else
        q_temp <= d;
end

always @(negedge clk)
begin
    q_delay <= q_temp;
    q <= q_delay;
end

endmodule
