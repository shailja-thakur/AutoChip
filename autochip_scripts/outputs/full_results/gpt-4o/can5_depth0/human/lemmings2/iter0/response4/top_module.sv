module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);
    // State encoding
    typedef enum logic [2:0] {
        LEFT = 3'b001,
        RIGHT = 3'b010,
        FALL_LEFT = 3'b101,
        FALL_RIGHT = 3'b110
    } state_t;
    
    state_t state, next;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next = FALL_LEFT;
                else if (bump_left)
                    next = RIGHT;
                else if (bump_right)
                    next = LEFT;
                else
                    next = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next = FALL_RIGHT;
                else if (bump_right)
                    next = LEFT;
                else if (bump_left)
                    next = RIGHT;
                else
                    next = RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next = LEFT;
                else
                    next = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next = RIGHT;
                else
                    next = FALL_RIGHT;
            end
            default: next = LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;  // Default state on asynchronous reset
        else
            state <= next;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    end

endmodule
