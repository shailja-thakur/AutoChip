module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q, state;

always @(posedge clk) begin
    state <= (a & b) | (a & state) | (b & state);
    q <= state;
end

endmodule
