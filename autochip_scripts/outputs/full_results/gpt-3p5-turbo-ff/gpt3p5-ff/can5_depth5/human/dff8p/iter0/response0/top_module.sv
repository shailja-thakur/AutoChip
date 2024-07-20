module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

reg [7:0] q_temp;
reg [7:0] q_rst;

always @(posedge clk or negedge reset) begin
    if (reset == 0) begin
        q_rst <= 8'b00110100;
    end else if (posedge clk) begin
        q_rst <= d;
    end
end

always @(negedge clk or negedge reset) begin
    if (reset == 0) begin
        q_temp <= q_rst;
    end else if (negedge clk) begin
        q_temp <= d;
    end
end

always @(posedge clk) begin
    q <= q_temp;
end

endmodule
