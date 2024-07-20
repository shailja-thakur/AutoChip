module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
localparam STATE_WALK_LEFT  = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

// Internal state register
reg current_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset to walk left state
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                if (bump_right) begin
                    // Switch to walk right state
                    current_state <= STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                if (bump_left) begin
                    // Switch to walk left state
                    current_state <= STATE_WALK_LEFT;
                end
            end
            default: begin
                // Undefined state, reset to walk left state
                current_state <= STATE_WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end
end

endmodule
