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

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;
    
    state_t state, next_state;
    int fall_count;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall_count <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
                FALL: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                end
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_count <= 0;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    fall_count <= 0;
                end
                SPLATTER: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= fall_count;
                end
                default: begin
                    // Default case to handle unexpected states
                    state <= WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
            endcase
        end
    end
    
    always_comb begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
            end
            FALL: begin
                if (fall_count > 20)
                    next_state = SPLATTER;
                else if (ground)
                    if (walk_left)
                        next_state = WALK_LEFT;
                    else
                        next_state = WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL;
            end
            SPLATTER: begin
                // splatter state is terminal, no transition out
                next_state = SPLATTER;
            end
            default: begin
                // Default case to handle unexpected states
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule
