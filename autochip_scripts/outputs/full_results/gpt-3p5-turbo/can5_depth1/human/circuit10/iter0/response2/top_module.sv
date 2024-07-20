module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= a & b;
    q <= state ? 1'b1 : 1'b0;
end

endmodule
