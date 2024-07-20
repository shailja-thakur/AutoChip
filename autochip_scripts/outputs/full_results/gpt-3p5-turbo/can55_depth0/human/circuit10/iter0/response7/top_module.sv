module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg ff;

always @(posedge clk) begin
    ff <= a & ~b;
    q <= ff;
    state <= ff | b;
end

endmodule
