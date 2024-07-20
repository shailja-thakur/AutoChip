module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// States
typedef enum logic [1:0] {
    S_WALK_LEFT = 2'b00,
    S_WALK_RIGHT = 2'b01
} state_t;

state_t state, next_state;

// State transition
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= S_WALK_LEFT;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        S_WALK_LEFT: begin
            if (bump_left)
                next_state = S_WALK_RIGHT;
            else
                next_state = S_WALK_LEFT;
        end
        S_WALK_RIGHT: begin
            if (bump_right)
                next_state = S_WALK_LEFT;
            else
                next_state = S_WALK_RIGHT;
        end
        default: next_state = S_WALK_LEFT; // default state
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
        end
        S_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
        end
        default: begin
            walk_left = 1;
            walk_right = 0;
        end
    endcase
end

endmodule
