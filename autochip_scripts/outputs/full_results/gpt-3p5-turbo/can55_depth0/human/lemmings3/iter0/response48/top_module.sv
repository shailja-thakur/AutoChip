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

// Enumerated type for the states
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG
} state_t;

reg state_t current_state, next_state;

always @(posedge clk or posedge areset)
    if (areset)
        current_state <= WALK_LEFT;
    else
        current_state <= next_state; // Combiantional logic updates the state
    
always @(current_state or bump_left or bump_right or ground or dig)
    case (current_state)
        WALK_LEFT:
            if (bump_right || (bump_left && bump_right))
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_LEFT;
        
        WALK_RIGHT:
            if (bump_left || (bump_left && bump_right))
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
            else
                next_state = WALK_RIGHT;
        
        FALL:
            if (ground)
                next_state = current_state;
            else if (dig)
                next_state = current_state;
            else
                next_state = FALL;
            
        DIG:
            if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
	    else if (bump_right || (bump_left && bump_right))
                next_state = WALK_RIGHT;
            else if (bump_left || (bump_left && bump_right))
                next_state = WALK_LEFT;
            else
                next_state = DIG;
                
    endcase
    
always @(current_state)
    case (current_state)
        WALK_LEFT:
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            
        WALK_RIGHT:
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            
        FALL:
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            
        DIG:
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
    endcase

endmodule
