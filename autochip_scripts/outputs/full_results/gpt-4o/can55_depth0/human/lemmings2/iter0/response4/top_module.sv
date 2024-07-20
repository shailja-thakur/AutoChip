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
        LEFT = 3'd0,  
        RIGHT = 3'd1, 
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;  // On reset, start walking left
        else
            state <= next_state;
    end

    always @(*) begin
        // Default output values
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;

        case (state)
            LEFT: begin
                if (ground == 0)
                    next_state = FALL_LEFT;
                else if (bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
                walk_left = 1'b1;
            end

            RIGHT: begin
                if (ground == 0)
                    next_state = FALL_RIGHT;
                else if (bump_left)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
                walk_right = 1'b1;
            end

            FALL_LEFT: begin
                if (ground == 1)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
                aaah = 1'b1;
            end

            FALL_RIGHT: begin
                if (ground == 1)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
                aaah = 1'b1;
            end

            default: next_state = LEFT;
        endcase
    end

endmodule
