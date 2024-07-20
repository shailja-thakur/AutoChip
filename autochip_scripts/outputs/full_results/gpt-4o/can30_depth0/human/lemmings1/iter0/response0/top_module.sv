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
        LEFT = 2'b00,  // State where Lemming is walking left
        RIGHT = 2'b01  // State where Lemming is walking right
    } state_t;
    
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;  // On reset, Lemming should walk left
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            LEFT: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = RIGHT;  // Switch to walking right on bump to the left
                end else begin
                    next_state = LEFT;    // Continue walking left
                end
            end
            RIGHT: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = LEFT;   // Switch to walking left on bump to the right
                end else begin
                    next_state = RIGHT;  // Continue walking right
                end
            end
            default: begin
                next_state = LEFT;  // Default state to LEFT
            end
        endcase
    end
    
    // Outputs based on current state
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
