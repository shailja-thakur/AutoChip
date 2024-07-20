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
        WALK_LEFT = 3'd0,
        WALK_RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLAT = 3'd6
    } state_t;
  
    state_t state, next_state;
  
    reg [4:0] fall_count; // Counter for fall duration, up to 32
    
    // State transition and counter logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 5'd0;
        end
        else begin
            state <= next_state;
            
            if (state == FALL_LEFT || state == FALL_RIGHT) // Increase fall count only if falling
                fall_count <= fall_count + 1;
            else
                fall_count <= 5'd0;
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
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
            
            FALL_LEFT: begin
                if (fall_count >= 5'd20) 
                    next_state = SPLAT;
                else if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (fall_count >= 5'd20)
                    next_state = SPLAT;
                else if (ground)
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
            
            SPLAT: begin
                next_state = SPLAT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end
    
    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
        digging = (state == DIG_LEFT || state == DIG_RIGHT);
        
        // Override outputs in SPLAT state
        if (state == SPLAT) begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
    end
endmodule
