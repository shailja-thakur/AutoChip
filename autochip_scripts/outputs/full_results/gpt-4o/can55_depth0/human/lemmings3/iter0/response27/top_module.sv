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

    // Define state encoding
    typedef enum logic [3:0] {
        WLK_LEFT = 4'b0001,
        WLK_RIGHT = 4'b0010,
        FALL_LEFT = 4'b0100,
        FALL_RIGHT = 4'b1000,
        DIG_LEFT = 4'b0101,
        DIG_RIGHT = 4'b1010
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WLK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default state is the same
        case (state)
            WLK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WLK_RIGHT;
            end

            WLK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WLK_LEFT;
            end

            FALL_LEFT: begin
                if (ground)
                    next_state = WLK_LEFT;
            end

            FALL_RIGHT: begin
                if (ground)
                    next_state = WLK_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end

            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end

            default: next_state = WLK_LEFT;
        endcase
    end

    // Output logic based on state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                WLK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end

                WLK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end

                FALL_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end

                FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
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

                default: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end
endmodule
