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

    // State definition
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL
    } state_type;
    
    // Current state
    state_type state;
    
    // Next state
    state_type next_state;
    
    // Outputs
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    
    // Synchronous reset
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            state <= WALK_LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case(state)
            WALK_LEFT: begin
                if (bump_left && !bump_right && ground) begin
                    next_state = WALK_RIGHT;
                end
                else if (!bump_left && !bump_right && !ground) begin
                    next_state = FALL;
                end
                else begin
                    next_state = WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (!bump_left && bump_right && ground) begin
                    next_state = WALK_LEFT;
                end
                else if (!bump_left && !bump_right && !ground) begin
                    next_state = FALL;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
            
            FALL: begin
                if (bump_left && !bump_right) begin
                    next_state = WALK_RIGHT;
                end
                else if (!bump_left && bump_right) begin
                    next_state = WALK_LEFT;
                end
                else if (ground) begin
                    next_state = (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
                else begin
                    next_state = FALL;
                end
            end
        endcase
    end
endmodule
