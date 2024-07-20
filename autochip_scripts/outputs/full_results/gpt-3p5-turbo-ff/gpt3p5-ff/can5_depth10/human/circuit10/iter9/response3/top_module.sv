module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    q <= b;
    state <= (a & ~b) | (state & ~a);
end

endmodule
