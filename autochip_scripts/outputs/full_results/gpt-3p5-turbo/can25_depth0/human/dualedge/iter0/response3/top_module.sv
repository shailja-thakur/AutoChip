module top_module(
    input wire clk,
    input wire d,
    output reg q,
    reg q_d1,
    reg q_d2);

always @(posedge clk) begin
    q_d1 <= d;
end

always @(negedge clk) begin
    q_d2 <= q_d1;
    q <= q_d2;
end

endmodule
