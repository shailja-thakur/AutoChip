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

    typedef enum logic [2:0] {
        LEFT  = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state; // Default to remain in current state
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (bump_left) next_state = RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (bump_left) next_state = RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground) next_state = (state == FALL_LEFT) ? LEFT : RIGHT;
            end
        endcase
    end

    // State flip-flops with synchronous and asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        case (state)
            LEFT: walk_left = 1'b1;
            RIGHT: walk_right = 1'b1;
            FALL_LEFT, FALL_RIGHT: aaah = 1'b1;
        endcase
    end

endmodule
