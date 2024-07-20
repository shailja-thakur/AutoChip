module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

    typedef enum logic [2:0] {
        LEFT_WALK = 3'd0,
        RIGHT_WALK = 3'd1,
        LEFT_FALL = 3'd2,
        RIGHT_FALL = 3'd3,
        LEFT_DIG = 3'd4,
        RIGHT_DIG = 3'd5
    } state_t;
    
    state_t state, next_state;
    
    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT_WALK;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            LEFT_WALK: begin
                if (!ground)
                    next_state = LEFT_FALL;
                else if (dig)
                    next_state = LEFT_DIG;
                else if (bump_left)
                    next_state = RIGHT_WALK;
                else
                    next_state = LEFT_WALK;
            end
            RIGHT_WALK: begin
                if (!ground)
                    next_state = RIGHT_FALL;
                else if (dig)
                    next_state = RIGHT_DIG;
                else if (bump_right)
                    next_state = LEFT_WALK;
                else
                    next_state = RIGHT_WALK;
            end
            LEFT_FALL: begin
                if (ground)
                    next_state = LEFT_WALK;
                else
                    next_state = LEFT_FALL;
            end
            RIGHT_FALL: begin
                if (ground)
                    next_state = RIGHT_WALK;
                else
                    next_state = RIGHT_FALL;
            end
            LEFT_DIG: begin
                if (!ground)
                    next_state = LEFT_FALL;
                else
                    next_state = LEFT_DIG;
            end
            RIGHT_DIG: begin
                if (!ground)
                    next_state = RIGHT_FALL;
                else
                    next_state = RIGHT_DIG;
            end
            default: next_state = LEFT_WALK;
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT_WALK);
    assign walk_right = (state == RIGHT_WALK);
    assign aaah = (state == LEFT_FALL) || (state == RIGHT_FALL);
    assign digging = (state == LEFT_DIG) || (state == RIGHT_DIG);

endmodule
