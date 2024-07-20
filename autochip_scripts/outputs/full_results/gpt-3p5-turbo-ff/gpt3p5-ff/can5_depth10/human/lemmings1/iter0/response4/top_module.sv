module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

// Define the states of the finite state machine
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT
} state_t;

// Define the internal state and output signals
reg state_reg, next_state_reg;
reg walk_left_reg, walk_right_reg;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset, initialize to walk left state
        state_reg <= WALK_LEFT;
    end else begin
        // Synchronous state transition logic
        state_reg <= next_state_reg;
    end
end

always_comb begin
    // Default values
    walk_left_reg = 1'b0;
    walk_right_reg = 1'b0;

    // State outputs
    case (state_reg)
        WALK_LEFT: begin
            walk_left_reg = 1'b1;
            walk_right_reg = 1'b0;
        end
        WALK_RIGHT: begin
            walk_left_reg = 1'b0;
            walk_right_reg = 1'b1;
        end
    endcase
end

// Output assignments
assign walk_left = walk_left_reg;
assign walk_right = walk_right_reg;

// Next state logic
always_comb begin
    next_state_reg = state_reg;

    case (state_reg)
        WALK_LEFT: begin
            if (bump_right || (bump_left && bump_right)) begin
                next_state_reg = WALK_RIGHT;
            end
        end
        WALK_RIGHT: begin
            if (bump_left || (bump_left && bump_right)) begin
                next_state_reg = WALK_LEFT;
            end
        end
    endcase
end

endmodule
