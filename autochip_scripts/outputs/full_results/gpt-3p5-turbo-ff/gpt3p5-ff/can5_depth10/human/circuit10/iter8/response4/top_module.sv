module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= ((a & ~b) | (state & ~a));
    q <= state;
end

endmodule
