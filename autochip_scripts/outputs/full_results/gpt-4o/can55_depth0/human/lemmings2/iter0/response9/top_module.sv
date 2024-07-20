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

    typedef enum logic[2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        FALL = 3'b100
    } state_t;
 
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state; // Default to hold state
        case (state)
            WALK_LEFT: begin
                if (~ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT; // Continue walking left
                end
            end
            WALK_RIGHT: begin
                if (~ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT; // Continue walking right
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end
            end
            default: next_state = WALK_LEFT; // safeguard
        endcase
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        
        case (state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL_LEFT, FALL_RIGHT: aaah = 1'b1;
            default: /* default catch-all */
        endcase
    end

endmodule
