module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
    // State encoding
    typedef enum reg {LEFT, RIGHT} state_t;
    state_t state, next_state;

    // State Transition
    always @(*) begin
        case (state)
            LEFT: next_state = (bump_left) ? RIGHT : LEFT;
            RIGHT: next_state = (bump_right) ? LEFT : RIGHT;
            default: next_state = LEFT;
        endcase
    end

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
