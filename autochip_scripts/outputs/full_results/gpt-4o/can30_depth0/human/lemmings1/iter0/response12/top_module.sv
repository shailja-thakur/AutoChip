module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition on clock and reset handling
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);

endmodule
