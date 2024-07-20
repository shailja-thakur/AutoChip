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

    // Definition of the states
    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011,
        DIGGING_LEFT = 3'b100,
        DIGGING_RIGHT = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            
            FALLING_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            
            FALLING_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
            
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else
                    next_state = DIGGING_LEFT;
            end
            
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else
                    next_state = DIGGING_RIGHT;
            end
            
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALLING_LEFT, FALLING_RIGHT: aaah = 1;
            DIGGING_LEFT: digging = 1;
            DIGGING_RIGHT: digging = 1;
        endcase
    end

endmodule
