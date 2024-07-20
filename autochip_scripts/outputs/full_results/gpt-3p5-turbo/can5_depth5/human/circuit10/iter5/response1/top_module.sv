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
    if (b == 0) begin
        state_reg <= 0;
    end else if (a == 1) begin
        state_reg <= ~state_reg;
    end
    
    if (a == 1 && state_reg == 0) begin
        q_reg <= 1;
    end else begin
        q_reg <= 0;
    end
end

// Output assignment
always @(state_reg, q_reg) begin
    q = q_reg;
    state = state_reg;
end

endmodule
