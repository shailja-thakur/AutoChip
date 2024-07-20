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

    // Define the states
    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end

            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end

            default: next_state = LEFT;
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case (next_state)
                LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end

                RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end

                FALL_LEFT, FALL_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                end

                DIG_LEFT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                end

                DIG_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                end
                
                default: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end
            endcase
        end
    end

endmodule
