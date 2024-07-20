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

    // Define state encoding
    typedef enum logic [2:0] {
        WALK_LEFT    = 3'b000,
        WALK_RIGHT   = 3'b001,
        FALL_LEFT    = 3'b010,
        FALL_RIGHT   = 3'b011,
        DIG_LEFT     = 3'b100,
        DIG_RIGHT    = 3'b101,
        FALL_DIG     = 3'b110    // Intermediate state while falling during dig
    } state_t;
    
    state_t state, next_state;

    // State Register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Next-State Logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
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
            
            FALL_LEFT, FALL_RIGHT: begin
                if (ground)
                    next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = state;
            end

            
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_DIG;
                else
                    next_state = state;
            end

            FALL_DIG: begin
                if (ground)
                    next_state = (state == DIG_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = FALL_DIG;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // Output Logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT) || (state == FALL_DIG);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

endmodule
