module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

// State encoding
typedef enum logic [2:0] {
    WALK_LEFT = 3'b000,
    WALK_RIGHT = 3'b001,
    FALLING_LEFT = 3'b010,
    FALLING_RIGHT = 3'b011,
    DIGGING_LEFT = 3'b100,
    DIGGING_RIGHT = 3'b101,
    FALLING_DIG_LEFT = 3'b110,
    FALLING_DIG_RIGHT = 3'b111    
} state_t;

state_t state, next_state;

// State transition
always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (!ground)
                next_state = FALLING_LEFT;
            else if (dig)
                next_state = DIGGING_LEFT;
            else if (bump_left || bump_right)
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (!ground)
                next_state = FALLING_RIGHT;
            else if (dig)
                next_state = DIGGING_RIGHT;
            else if (bump_left || bump_right)
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end
        FALLING_LEFT: begin
            if (ground)
                next_state = WALK_LEFT;
            else
                next_state = FALLING_LEFT;
        end
        FALLING_RIGHT: begin
            if (ground)
                next_state = WALK_RIGHT;
            else
                next_state = FALLING_RIGHT;
        end
        DIGGING_LEFT: begin
            if (!ground)
                next_state = FALLING_LEFT;
            else
                next_state = DIGGING_LEFT;
        end
        DIGGING_RIGHT: begin
            if (!ground)
                next_state = FALLING_RIGHT;
            else
                next_state = DIGGING_RIGHT;
        end
        default: next_state = WALK_LEFT; // Default to walking left
    endcase
end

// State register
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: walk_left = 1;
        WALK_RIGHT: walk_right = 1;
        FALLING_LEFT: aaah = 1;
        FALLING_RIGHT: aaah = 1;
        DIGGING_LEFT: digging = 1;
        DIGGING_RIGHT: digging = 1;
    endcase
end

endmodule
