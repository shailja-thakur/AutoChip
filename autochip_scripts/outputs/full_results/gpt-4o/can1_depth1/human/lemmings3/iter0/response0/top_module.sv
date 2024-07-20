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
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        FALL_DIG_LEFT = 3'b110,
        FALL_DIG_RIGHT = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State Transition
    always @(*) begin
        case (current_state)
            // Walking states
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end

            // Falling states
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            // Digging states
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_DIG_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_DIG_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            
            // Fall while digging
            FALL_DIG_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_DIG_LEFT;
            end
            FALL_DIG_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_DIG_RIGHT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(*) begin
        // Default values
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL_LEFT, FALL_RIGHT, FALL_DIG_LEFT, FALL_DIG_RIGHT: aaah = 1'b1;
            DIG_LEFT: digging = 1'b1;
            DIG_RIGHT: digging = 1'b1;
        endcase
    end

endmodule
