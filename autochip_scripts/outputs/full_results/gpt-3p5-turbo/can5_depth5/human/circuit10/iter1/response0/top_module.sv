module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

// Internal signal declaration
reg q_reg;
reg state_reg;

// Register assignments at time 0ns
initial begin
    q_reg = 1'b0;   // Initial value of q
    state_reg = 1'b0;   // Initial value of state
end

// Flip-flop logic
always @(posedge clk) begin
    q_reg <= a & ~state_reg;
    state_reg <= b | (state_reg & ~q_reg);
end

// Output assignment
assign q = q_reg;
assign state = state_reg;

endmodule
