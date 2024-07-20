module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

// Define the states
parameter STATE_WALK_LEFT = 1'b0;
parameter STATE_WALK_RIGHT = 1'b1;

// Current and next state
reg current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else
                next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else
                next_state = STATE_WALK_RIGHT;
        end
        default: begin
            next_state = current_state;
        end
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
        end
        STATE_WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
        end
        default: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = ground ? 1'b0 : 1'b1;
        end
    endcase
end

// State update logic
always @(posedge clk, posedge areset) begin
    if (areset)
        current_state <= STATE_WALK_LEFT;
    else
        current_state <= next_state;
end

endmodule
