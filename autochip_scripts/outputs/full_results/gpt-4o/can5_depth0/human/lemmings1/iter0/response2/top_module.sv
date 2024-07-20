module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define states using local parameters
localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

// State variable
reg state, next_state;

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @ (*) begin
    // Default next state to the current state
    next_state = state;
    
    case (state)
        STATE_WALK_LEFT: begin
            // If bumped on the left, switch to walk right
            if (bump_left) begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_WALK_RIGHT: begin
            // If bumped on the right, switch to walk left
            if (bump_right) begin
                next_state = STATE_WALK_LEFT;
            end
        end
    endcase
end

always @ (posedge clk) begin
    if (areset) begin
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
            end
        endcase
    end
end

endmodule
