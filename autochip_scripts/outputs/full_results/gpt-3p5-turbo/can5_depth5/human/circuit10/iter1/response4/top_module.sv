module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// Internal signal declaration
reg q_reg;
reg state_reg;

// Flip-flop logic
always @(posedge clk) begin
    q_reg <= a & ~state_reg;
    state_reg <= b | (state_reg & ~q_reg);
end

// Output assignment
always @(posedge clk) begin
    q <= q_reg;
    state <= state_reg;
end

endmodule
