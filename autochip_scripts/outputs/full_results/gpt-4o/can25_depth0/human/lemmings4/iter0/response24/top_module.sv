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
  
    // State declaration
    typedef enum reg [2:0] {
        S_WALK_LEFT,
        S_WALK_RIGHT,
        S_FALL_LEFT,
        S_FALL_RIGHT,
        S_DIG_LEFT,
        S_DIG_RIGHT,
        S_SPLATTER
    } state_t;
    
    state_t state, next_state;
    reg [4:0] fall_count;
    
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            
            if (state == S_FALL_LEFT || state == S_FALL_RIGHT) 
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end
    
    always @ (*) begin
        next_state = state; // Default to same state
        
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
            end

            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
            end

            S_FALL_LEFT, S_FALL_RIGHT: begin
                if (fall_count >= 20 && ground)
                    next_state = S_SPLATTER;
                else if (ground) begin
                    if (state == S_FALL_LEFT)
                        next_state = S_WALK_LEFT;
                    else
                        next_state = S_WALK_RIGHT;
                end
            end
            
            S_DIG_LEFT, S_DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == S_DIG_LEFT) ? S_FALL_LEFT : S_FALL_RIGHT;
            end
            
            S_SPLATTER: begin
                // Remain in this state
            end
            
            default: next_state = S_WALK_LEFT;
        endcase
    end
    
    assign walk_left  = (state == S_WALK_LEFT);
    assign walk_right = (state == S_WALK_RIGHT);
    assign aaah       = (state == S_FALL_LEFT || state == S_FALL_RIGHT);
    assign digging    = (state == S_DIG_LEFT || state == S_DIG_RIGHT);
    
endmodule
