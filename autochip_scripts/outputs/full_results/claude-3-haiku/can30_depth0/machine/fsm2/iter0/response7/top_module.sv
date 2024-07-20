module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
reg next_state;

// Combinational always block to determine the next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j) next_state = 1'b1; // State B
            else next_state = 1'b0; // State A
        1'b1: // State B
            if (k) next_state = 1'b0; // State A
            else next_state = 1'b1; // State B
        default: next_state = 1'b0; // Default to State A
    endcase
end

// Clocked always block to update the state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end
    else begin
        state <= next_state;
    end
end

// Assign the output based on the current state
assign out = state;

endmodule
