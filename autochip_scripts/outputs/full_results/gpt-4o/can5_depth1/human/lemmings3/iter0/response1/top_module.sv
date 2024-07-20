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

    // State encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    // Output generation
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT; // Asynchronous reset to walk left
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state generation
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT; // Falling has the highest priority
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            
            WALK_RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

endmodule
