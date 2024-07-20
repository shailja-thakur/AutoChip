module top_module(
    input clk,
    input d,
    output reg q
);

reg q_next;

always @(posedge clk) begin
    q <= q_next;
end

always @(posedge clk, negedge clk) begin
    if (clk) begin
        q_next <= d;
    end
end

endmodule
