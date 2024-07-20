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

// State enumeration
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} state_t;

// Flip-flops for state and output
reg [1:0] current_state, next_state;
reg walk_left_reg, walk_right_reg, aaah_reg;

// Synchronous reset on positive edge of areset
always_ff @(posedge areset or posedge clk) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        walk_left_reg <= 0;
        walk_right_reg <= 0;
        aaah_reg <= 0;
    end else begin
        current_state <= next_state;
        walk_left_reg <= walk_left_reg;
        walk_right_reg <= walk_right_reg;
        aaah_reg <= aaah_reg;
    end
end

// Assigning next state and outputs based on current state and inputs
always_comb begin
    case (current_state)
        WALK_LEFT:
            begin
                if (bump_right && !bump_left)
                    next_state = WALK_RIGHT;
                else if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL;
                
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
        WALK_RIGHT:
            begin
                if (bump_left && !bump_right)
                    next_state = WALK_LEFT;
                else if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL;
                
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
        FALL:
            begin
                if (ground)
                    next_state = current_state; // Resume walking in the same direction before falling
                else
                    next_state = FALL;
                
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
    endcase
end

endmodule
