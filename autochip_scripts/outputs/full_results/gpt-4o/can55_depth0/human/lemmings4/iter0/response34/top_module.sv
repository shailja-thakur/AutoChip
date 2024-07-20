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
    typedef enum reg [3:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTERED
    } state_t;

    state_t state, next_state;
    
    reg [4:0] fall_count;

    // State transitions
    always @(*) begin
        case(state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLATTERED;
                    else next_state = WALK_LEFT;
                end else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLATTERED;
                    else next_state = WALK_RIGHT;
                end else next_state = FALL_RIGHT;
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State updates and outputs
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;

            case(next_state)
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
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                FALL_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                end
                FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    fall_count <= fall_count + 1;
                end
                SPLATTERED: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    fall_count <= 0;
                end
            endcase
        end
    end

endmodule
