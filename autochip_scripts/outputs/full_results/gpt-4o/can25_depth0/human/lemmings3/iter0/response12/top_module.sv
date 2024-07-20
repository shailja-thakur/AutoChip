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
        LEFT = 3'b000,
        RIGHT = 3'b001,
        DIG_LEFT = 3'b010,
        DIG_RIGHT = 3'b011,
        FALL_LEFT = 3'b100,
        FALL_RIGHT = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always @(*) begin
        // Default state assignments
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
            end
            RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
            end
            DIG_LEFT: begin
                digging = 1;
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                digging = 1;
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            FALL_LEFT: begin
                aaah = 1;
                if (ground)
                    next_state = LEFT;
            end
            FALL_RIGHT: begin
                aaah = 1;
                if (ground)
                    next_state = RIGHT;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end

endmodule
