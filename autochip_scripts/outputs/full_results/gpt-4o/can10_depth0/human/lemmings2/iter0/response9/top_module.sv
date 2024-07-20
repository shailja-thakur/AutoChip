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

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL_LEFT = 2'b10,
        STATE_FALL_RIGHT = 2'b11
    } state_t;

    state_t present_state, next_state;

    // State transition logic
    always @(*) begin
        case (present_state)
            STATE_WALK_LEFT: begin
                if (!ground) 
                    next_state = STATE_FALL_LEFT;
                else if (bump_left) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                if (ground) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_FALL_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            present_state <= STATE_WALK_LEFT;
        else
            present_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (present_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            STATE_FALL_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            STATE_FALL_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
        endcase
    end

endmodule
