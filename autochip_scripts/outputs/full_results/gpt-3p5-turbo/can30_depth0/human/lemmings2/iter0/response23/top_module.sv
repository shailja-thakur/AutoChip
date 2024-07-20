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
    
    // Define state enum
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL
    } state_t;
    
    // Define state register and current state
    reg state_t state_reg;
    state_t curr_state;
    
    // Define outputs
    reg walk_left;
    reg walk_right;
    reg aaah;
    
    // Asynchronous reset
    always @(posedge areset) begin
        state_reg <= WALK_LEFT;
    end
    
    // Moore state machine
    always @(posedge clk) begin
        curr_state <= state_reg;
        
        // next state logic
        case (curr_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state_reg <= WALK_RIGHT;
                end else if (!ground) begin
                    state_reg <= FALL;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state_reg <= WALK_LEFT;
                end else if (!ground) begin
                    state_reg <= FALL;
                end
            end
            FALL: begin
                if (ground) begin
                    if (curr_state == WALK_LEFT) begin
                        state_reg <= WALK_LEFT;
                    end else if (curr_state == WALK_RIGHT) begin
                        state_reg <= WALK_RIGHT;
                    end
                end
            end
            default: begin
                state_reg <= WALK_LEFT;
            end
        endcase
    end
    
    // Output logic
    always @(curr_state, ground) begin
        walk_left  <= (curr_state == WALK_LEFT) ? 1 : 0;
        walk_right <= (curr_state == WALK_RIGHT) ? 1 : 0;
        aaah       <= (curr_state == FALL && !ground) ? 1 : 0;
    end

endmodule
