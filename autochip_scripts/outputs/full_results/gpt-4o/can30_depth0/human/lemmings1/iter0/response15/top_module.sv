module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

    // Define the state enumeration
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
    end

endmodule
