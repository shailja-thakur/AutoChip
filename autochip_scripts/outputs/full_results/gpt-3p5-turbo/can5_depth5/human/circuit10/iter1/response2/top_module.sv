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

// Flip-flop logic
always @(posedge clk) begin
    // Update state_reg based on b input
    if (b) begin
        state_reg <= 1'b1;
    end else begin
        state_reg <= 1'b0;
    end
    
    // Update q_reg based on a and state_reg inputs
    if (a && ~state_reg) begin
        q_reg <= 1'b1;
    end else begin
        q_reg <= 1'b0;
    end
end

// Output assignment
assign q = q_reg;
assign state = state_reg;

endmodule
