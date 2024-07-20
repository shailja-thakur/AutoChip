module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg state_next;

always @(posedge clk) begin
    if (~a & b)
        state_next <= 1'b1;
    else
        state_next <= 1'b0;
end

always @(posedge clk) begin
    state <= state_next;
end

always @(posedge clk) begin
    q <= state;
end

endmodule
