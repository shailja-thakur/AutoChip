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
        WALK_LEFT=3'b000,
        WALK_RIGHT=3'b001,
        FALL_LEFT=3'b010,
        FALL_RIGHT=3'b011,
        DIGGING_LEFT=3'b100,
        DIGGING_RIGHT=3'b101
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else 
                    next_state = WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end

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

            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIGGING_LEFT;
            end

            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIGGING_RIGHT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        // Default all outputs to zero
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        // Set the output based on the current state
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
            end

            WALK_RIGHT: begin
                walk_right = 1;
            end

            FALL_LEFT: begin
                aaah = 1;
            end

            FALL_RIGHT: begin
                aaah = 1;
            end

            DIGGING_LEFT: begin
                digging = 1;
            end

            DIGGING_RIGHT: begin
                digging = 1;
            end
        endcase
    end
endmodule
