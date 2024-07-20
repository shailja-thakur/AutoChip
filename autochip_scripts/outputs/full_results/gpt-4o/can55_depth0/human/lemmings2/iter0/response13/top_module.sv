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

    // Define states as parameters
    parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11;
    reg [1:0] state, next_state;

    // State transition logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;  // Asynchronous reset to walking left
        end else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)
                    next_state = FALL_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALL_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
        endcase
    end

endmodule
