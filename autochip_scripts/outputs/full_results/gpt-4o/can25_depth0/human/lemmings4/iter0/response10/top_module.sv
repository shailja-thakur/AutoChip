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

    // Define states
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'd0,
        S_WALK_RIGHT = 3'd1,
        S_FALL_LEFT = 3'd2,
        S_FALL_RIGHT = 3'd3,
        S_DIG_LEFT = 3'd4,
        S_DIG_RIGHT = 3'd5,
        S_SPLATTER = 3'd6
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count; // 5-bit counter for counting falling cycles

    // State transition logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (~ground) 
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            S_WALK_RIGHT: begin
                if (~ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            S_FALL_LEFT: begin
                if (ground && fall_count <= 20)
                    next_state = S_WALK_LEFT;
                else if (ground && fall_count > 20)
                    next_state = S_SPLATTER;
                else
                    next_state = S_FALL_LEFT;
            end
            S_FALL_RIGHT: begin
                if (ground && fall_count <= 20)
                    next_state = S_WALK_RIGHT;
                else if (ground && fall_count > 20)
                    next_state = S_SPLATTER;
                else
                    next_state = S_FALL_RIGHT;
            end
            S_DIG_LEFT: begin
                if (~ground)
                    next_state = S_FALL_LEFT;
                else
                    next_state = S_DIG_LEFT;
            end
            S_DIG_RIGHT: begin
                if (~ground)
                    next_state = S_FALL_RIGHT;
                else
                    next_state = S_DIG_RIGHT;
            end
            S_SPLATTER: begin
                next_state = S_SPLATTER; // Stay in splatter state
            end
            default: begin
                next_state = S_WALK_LEFT;
            end
        endcase
    end

    // State updating and falling counter
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;

            if (state == S_FALL_LEFT || state == S_FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            S_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            S_FALL_LEFT, S_FALL_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
            S_DIG_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
            S_DIG_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
            S_SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
