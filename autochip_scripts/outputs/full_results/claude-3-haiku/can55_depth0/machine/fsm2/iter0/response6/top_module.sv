module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State transition logic
always @(*) begin
    case (state)
        1'b0: // State A
            if (j) begin
                next_state = 1'b1; // Transition to state B
            end else begin
                next_state = 1'b0; // Remain in state A
            end
        1'b1: // State B
            if (k) begin
                next_state = 1'b0; // Transition to state A
            end else begin
                next_state = 1'b1; // Remain in state B
            end
        default: begin
            next_state = 1'b0; // Default to state A
        end
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to state A
    end else begin
        state <= next_state;
    end
end

// Output logic
assign out = state; // Output the current state

endmodule
