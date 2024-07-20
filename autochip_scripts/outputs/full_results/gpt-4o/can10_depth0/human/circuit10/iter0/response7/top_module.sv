module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= (a & b) | (~a & ~b);  // State generation logic
    q <= state;  // q is directly derived from state
end

endmodule
