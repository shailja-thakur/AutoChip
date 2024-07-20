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

    // State encoding
    typedef enum logic [2:0] {
        LEFT = 3'b000,      // Walking left
        RIGHT = 3'b001,     // Walking right
        FALL_LEFT = 3'b010, // Falling (was walking left)
        FALL_RIGHT = 3'b011, // Falling (was walking right)
        DIG_LEFT = 3'b100,  // Digging (walking left)
        DIG_RIGHT = 3'b101, // Digging (walking right)
        SPLATTER = 3'b110   // Splattered
    } state_t;
    
    state_t state, next_state;
    logic [4:0] fall_counter; // 5-bit counter to count up to 20 cycles
    
    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (dig) 
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right) 
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right) 
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) 
                    next_state = (fall_counter > 20) ? SPLATTER : LEFT;
                else 
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) 
                    next_state = (fall_counter > 20) ? SPLATTER : RIGHT;
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
            SPLATTER: begin
                next_state = SPLATTER; // Remain in splatter state
            end
            default: next_state = LEFT; // Default state
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

endmodule
