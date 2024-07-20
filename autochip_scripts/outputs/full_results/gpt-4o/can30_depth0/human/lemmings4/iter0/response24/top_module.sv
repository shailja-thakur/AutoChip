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
    typedef enum reg [2:0] {
        S_WALK_LEFT = 3'd0,      // Walking left
        S_WALK_RIGHT = 3'd1,     // Walking right
        S_FALL_LEFT = 3'd2,      // Falling while previously walking left
        S_FALL_RIGHT = 3'd3,     // Falling while previously walking right
        S_DIG_LEFT = 3'd4,       // Digging while facing left
        S_DIG_RIGHT = 3'd5,      // Digging while facing right
        S_SPLATTERED = 3'd6      // Splattered
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count; // 5-bit counter for falling duration

    // State transition logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            S_FALL_LEFT, S_FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count >= 5'd20)
                        next_state = S_SPLATTERED;
                    else
                        next_state = (state == S_FALL_LEFT) ? S_WALK_LEFT : S_WALK_RIGHT;
                end else
                    next_state = state;
            end
            S_DIG_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else
                    next_state = S_DIG_LEFT;
            end
            S_DIG_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else
                    next_state = S_DIG_RIGHT;
            end
            S_SPLATTERED: begin
                next_state = S_SPLATTERED;
            end
            default: begin
                next_state = S_WALK_LEFT;
            end
        endcase
    end

    // State register and fall counter management
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            if (state == S_FALL_LEFT || state == S_FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 5'd0;
            end
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (state == S_WALK_LEFT);
        walk_right = (state == S_WALK_RIGHT);
        aaah = (state == S_FALL_LEFT || state == S_FALL_RIGHT);
        digging = (state == S_DIG_LEFT || state == S_DIG_RIGHT);
    end

endmodule
