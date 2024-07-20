module top_module(
    input clk,
    input d,
    output reg q);

reg q_p;
reg q_n;

always @(posedge clk) begin
    q_p <= d;
    q_n <= ~d;
end

always @(posedge clk or negedge q_n) begin
    q <= (q_p & q_n);
end

endmodule
