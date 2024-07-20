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
	// State definitions
    typedef enum logic [3:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;
    
    state_t state, next_state;
    
    reg [4:0] fall_counter; // Counter to keep track of fall duration

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT; // Higher precedence for falling
                else if (dig) next_state = DIG_LEFT; // Next precedence for digging
                else if (bump_left) next_state = WALK_RIGHT; // Change direction when bumped
                else next_state = WALK_LEFT; // Otherwise, keep walking left
            end
            
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLATTER; // Check for splatter condition
                    else next_state = WALK_LEFT; // resume walking left
                end
                else next_state = FALL_LEFT; // Keep falling
            end
            
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLATTER;
                    else next_state = WALK_RIGHT; // resume walking right
                end
                else next_state = FALL_RIGHT;
            end
            
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT; // Start falling if ground disappears
                else next_state = DIG_LEFT; // Keep digging
            end
            
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            
            SPLATTER: begin
                next_state = SPLATTER; // Remain in splatter state
            end
            
            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end
    
    // State and fall counter updates
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end
            else begin
                fall_counter <= 0;
            end
        end
    end
    
    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTER: begin
                // All outputs remain 0 in splatter state
            end
        endcase
    end

endmodule
