module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

// Internal state variables
reg [1:0] state;

// Moore outputs
assign walk_left = (state == 2'b00);
assign walk_right = (state == 2'b01);

// Synchronous state update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset to initial state
        state <= 2'b00;
    end else begin
        // State transitions based on inputs
        case (state)
            2'b00: begin
                if (bump_right) begin
                    // Switch to walk_right state if bumped on the right
                    state <= 2'b01;
                end else if (bump_left) begin
                    // Stay in walk_left state if bumped on the left
                    state <= 2'b00;
                end else begin
                    // Stay in current state
                    state <= 2'b00;
                end
            end
            2'b01: begin
                if (bump_left) begin
                    // Switch to walk_left state if bumped on the left
                    state <= 2'b00;
                end else if (bump_right) begin
                    // Stay in walk_right state if bumped on the right
                    state <= 2'b01;
                end else begin
                    // Stay in current state
                    state <= 2'b01;
                end
            end
            default: begin
                // Default case - should not reach this state
                state <= 2'b00;
            end
        endcase
    end
end

endmodule
