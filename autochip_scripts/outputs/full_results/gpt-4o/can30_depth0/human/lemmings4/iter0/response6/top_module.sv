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

    // State declarations
    typedef enum logic [3:0] {
        WALK_LEFT, WALK_RIGHT,
        FALLING_LEFT, FALLING_RIGHT,
        DIGGING_LEFT, DIGGING_RIGHT,
        SPLATTERED
    } state_t;
    
    state_t state, next_state;
    int fall_count;
    
    // State transition logic
    always @(*) begin
        next_state = state;
        
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if(dig)
                    next_state = DIGGING_LEFT;
                else if(bump_left)
                    next_state = WALK_RIGHT;
            end
            
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if(dig)
                    next_state = DIGGING_RIGHT;
                else if(bump_right)
                    next_state = WALK_LEFT;
            end
            
            FALLING_LEFT: begin
                if (ground)
                    next_state = (fall_count > 20) ? SPLATTERED : WALK_LEFT;
            end
            
            FALLING_RIGHT: begin
                if (ground)
                    next_state = (fall_count > 20) ? SPLATTERED : WALK_RIGHT;
            end
            
            DIGGING_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
            end
            
            DIGGING_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
            end
            
            SPLATTERED: begin
                // Remain in SPLATTERED state forever
                next_state = SPLATTERED;
            end
        endcase
    end
    
    // State and counter update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            if (state == FALLING_LEFT || state == FALLING_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;

            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
            end
            
            WALK_RIGHT: begin
                walk_right = 1;
            end
            
            FALLING_LEFT: begin
                aaah = 1;
            end
            
            FALLING_RIGHT: begin
                aaah = 1;
            end
            
            DIGGING_LEFT: begin
                digging = 1;
            end
            
            DIGGING_RIGHT: begin
                digging = 1;
            end
            
            SPLATTERED: begin
                // All outputs should remain 0
            end
        endcase
    end
endmodule
