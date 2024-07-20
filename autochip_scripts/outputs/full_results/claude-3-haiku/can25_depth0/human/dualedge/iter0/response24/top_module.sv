module top_module(
    input clk,
    input d,
    output reg q
);

reg tmp_q;

always @(posedge clk) begin
    q <= d;
end

always @(negedge clk) begin
    tmp_q <= d;
end

always @(posedge clk or negedge clk) begin
    q <= (q == tmp_q) ? q : tmp_q;
end

endmodule
