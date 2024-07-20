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
    state_reg <= b;
    q_reg <= a & ~state_reg;
end

// Output assignment
assign q = q_reg;
assign state = state_reg;

endmodule
