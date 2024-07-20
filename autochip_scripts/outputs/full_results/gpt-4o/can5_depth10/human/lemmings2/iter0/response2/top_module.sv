module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

    reg [2:0] state, next_state;

    // State encoding
    parameter LEFT      = 3'b000,
              RIGHT     = 3'b001,
              FALL_LEFT = 3'b010,
              FALL_RIGHT= 3'b011;

    // State transition logic (combination logic)
    always @(*) begin
        case (state)
            LEFT: begin
                if (ground == 0) 
                    next_state = FALL_LEFT;
                else if (bump_left) 
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end
            RIGHT: begin
                if (ground == 0) 
                    next_state = FALL_RIGHT;
                else if (bump_right) 
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground == 1) 
                    next_state = LEFT;
                else 
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground == 1) 
                    next_state = RIGHT;
                else 
                    next_state = FALL_RIGHT;
            end
            default: 
                next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= LEFT;
        else 
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
