module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);
    
    // State encoding
    typedef enum logic [2:0] {
        S_WALK_LEFT   = 3'd0,
        S_WALK_RIGHT  = 3'd1,
        S_FALL_LEFT   = 3'd2,
        S_FALL_RIGHT  = 3'd3,
        S_DIG_LEFT    = 3'd4,
        S_DIG_RIGHT   = 3'd5
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground) 
                    next_state = S_FALL_LEFT;
                else if (dig) 
                    next_state = S_DIG_LEFT;
                else if (bump_left) 
                    next_state = S_WALK_RIGHT;
                else 
                    next_state = S_WALK_LEFT;
            end
            
            S_WALK_RIGHT: begin
                if (!ground) 
                    next_state = S_FALL_RIGHT;
                else if (dig) 
                    next_state = S_DIG_RIGHT;
                else if (bump_right) 
                    next_state = S_WALK_LEFT;
                else 
                    next_state = S_WALK_RIGHT;
            end
            
            S_FALL_LEFT: begin
                if (ground) 
                    next_state = S_WALK_LEFT;
                else 
                    next_state = S_FALL_LEFT;
            end
            
            S_FALL_RIGHT: begin
                if (ground) 
                    next_state = S_WALK_RIGHT;
                else 
                    next_state = S_FALL_RIGHT;
            end
            
            S_DIG_LEFT: begin
                if (!ground) 
                    next_state = S_FALL_LEFT;
                else 
                    next_state = S_DIG_LEFT;
            end
            
            S_DIG_RIGHT: begin
                if (!ground) 
                    next_state = S_FALL_RIGHT;
                else 
                    next_state = S_DIG_RIGHT;
            end
            
            default: 
                next_state = S_WALK_LEFT;
        endcase
    end
    
    // State registers
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= S_WALK_LEFT;
        else 
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            S_WALK_LEFT: begin
                walk_left = 1;
            end
            
            S_WALK_RIGHT: begin
                walk_right = 1;
            end
            
            S_FALL_LEFT, S_FALL_RIGHT: begin
                aaah = 1;
            end
            
            S_DIG_LEFT: begin
                digging = 1;
                walk_left = 1; // It continues walking left while digging
            end
            
            S_DIG_RIGHT: begin
                digging = 1;
                walk_right = 1; // It continues walking right while digging
            end
        endcase
    end
    
endmodule
