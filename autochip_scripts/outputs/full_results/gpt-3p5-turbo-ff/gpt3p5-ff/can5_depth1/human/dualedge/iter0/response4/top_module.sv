module top_module(
    input clk,
    input d,
    output reg q);

reg ff1_q;
reg ff2_q;

always @(posedge clk) begin
    ff1_q <= d;
end

always @(negedge clk) begin
    ff2_q <= ff1_q;
end

always @(posedge clk) begin
    q <= ff2_q;
end

endmodule
