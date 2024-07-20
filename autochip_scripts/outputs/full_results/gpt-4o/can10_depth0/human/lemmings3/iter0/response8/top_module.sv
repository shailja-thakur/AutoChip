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
        S_WALK_LEFT = 3'd0,
        S_WALK_RIGHT = 3'd1,
        S_FALL_LEFT = 3'd2,
        S_FALL_RIGHT = 3'd3,
        S_DIG_LEFT = 3'd4,
        S_DIG_RIGHT = 3'd5
    } state_t;

    state_t state, next_state;

    // Output logic based on state
    always_comb begin
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
            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    // State transition logic
    always_comb begin
        case (state)
            S_WALK_LEFT: begin
                if (~ground) begin
                    next_state = S_FALL_LEFT;
                end else if (dig) begin
                    next_state = S_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end else if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end else begin
                    next_state = S_WALK_LEFT;
                end
            end
            S_WALK_RIGHT: begin
                if (~ground) begin
                    next_state = S_FALL_RIGHT;
                end else if (dig) begin
                    next_state = S_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end else if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end else begin
                    next_state = S_WALK_RIGHT;
                end
            end
            S_FALL_LEFT: begin
                if (ground) begin
                    next_state = S_WALK_LEFT;
                end else begin
                    next_state = S_FALL_LEFT;
                end
            end
            S_FALL_RIGHT: begin
                if (ground) begin
                    next_state = S_WALK_RIGHT;
                end else begin
                    next_state = S_FALL_RIGHT;
                end
            end
            S_DIG_LEFT: begin
                if (~ground) begin
                    next_state = S_FALL_LEFT;
                end else begin
                    next_state = S_DIG_LEFT;
                end
            end
            S_DIG_RIGHT: begin
                if (~ground) begin
                    next_state = S_FALL_RIGHT;
                end else begin
                    next_state = S_DIG_RIGHT;
                end
            end
            default: begin
                next_state = S_WALK_LEFT;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
endmodule
