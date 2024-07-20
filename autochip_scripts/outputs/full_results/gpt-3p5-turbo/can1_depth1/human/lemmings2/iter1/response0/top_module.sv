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
    
    // Synchronous reset
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            state <= WALK_LEFT;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Next state logic and outputs
    always_comb begin
        case(state)
            WALK_LEFT: begin
                if (bump_left && !bump_right && ground) begin
                    next_state = WALK_RIGHT;
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                end
                else if (!bump_left && !bump_right && !ground) begin
                    next_state = FALL;
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                end
                else begin
                    next_state = WALK_LEFT;
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                end
            end
            
            WALK_RIGHT: begin
                if (!bump_left && bump_right && ground) begin
                    next_state = WALK_LEFT;
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                end
                else if (!bump_left && !bump_right && !ground) begin
                    next_state = FALL;
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                end
                else begin
                    next_state = WALK_RIGHT;
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                end
            end
            
            FALL: begin
                if (bump_left && !bump_right) begin
                    next_state = WALK_RIGHT;
                    walk_left = 0;
                    walk_right = 1;
                    aaah = 0;
                end
                else if (!bump_left && bump_right) begin
                    next_state = WALK_LEFT;
                    walk_left = 1;
                    walk_right = 0;
                    aaah = 0;
                end
                else if (ground) begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                        walk_left = 1;
                        walk_right = 0;
                        aaah = 0;
                    end
                    else begin
                        next_state = WALK_RIGHT;
                        walk_left = 0;
                        walk_right = 1;
                        aaah = 0;
                    end
                end
                else begin
                    next_state = FALL;
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 1;
                end
            end
        endcase
    end
endmodule
