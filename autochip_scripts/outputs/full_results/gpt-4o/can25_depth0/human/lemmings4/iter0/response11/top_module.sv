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

    // Define states
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT = 3'b100,
        S_DIG_RIGHT = 3'b101,
        S_SPLAT = 3'b110
    } state_t;
    
    state_t current_state, next_state;
    int fall_count;
    
    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S_WALK_LEFT;
            fall_count <= 0;
        end else begin
            current_state <= next_state;
            
            if (current_state == S_FALL_LEFT || current_state == S_FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 0;
            end
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            S_WALK_LEFT: begin
                if (!ground) begin
                    next_state = S_FALL_LEFT;
                end else if (dig && ground) begin
                    next_state = S_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = S_WALK_RIGHT;
                end
            end
            
            S_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = S_FALL_RIGHT;
                end else if (dig && ground) begin
                    next_state = S_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = S_WALK_LEFT;
                end
            end
            
            S_FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = S_SPLAT;
                    end else begin
                        next_state = S_WALK_LEFT;
                    end
                end
            end
            
            S_FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20) begin
                        next_state = S_SPLAT;
                    end else begin
                        next_state = S_WALK_RIGHT;
                    end
                end
            end
            
            S_DIG_LEFT: begin
                if (!ground) begin
                    next_state = S_FALL_LEFT;
                end
            end
            
            S_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = S_FALL_RIGHT;
                end
            end
            
            S_SPLAT: begin
                next_state = S_SPLAT; // Remain in splat state
            end
            
            default: begin
                next_state = S_WALK_LEFT;
            end
        endcase
    end
    
    // Output logic
    always_comb begin
        // Default values
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (current_state)
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
                walk_left = 1;
            end
            
            S_DIG_RIGHT: begin
                digging = 1;
                walk_right = 1;
            end
            
            S_SPLAT: begin
                // All outputs already set to 0
            end
        endcase
    end

endmodule
