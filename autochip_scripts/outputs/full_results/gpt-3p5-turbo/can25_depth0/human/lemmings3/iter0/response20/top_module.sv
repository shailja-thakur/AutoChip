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
    
    // Define state enumeration
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        DIG_FALL
    } state_t;
    state_t state, next_state;
    
    // Define state outputs
    reg walk_left, walk_right, aaah, digging;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state and outputs
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            // Update next state based on current state and inputs
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        next_state <= WALK_RIGHT;
                    end else if (!ground) begin
                        next_state <= FALL;
                    end else if (dig) begin
                        next_state <= DIG;
                    end else begin
                        next_state <= WALK_LEFT;
                    end
                end
                
                WALK_RIGHT: begin
                    if (bump_left) begin
                        next_state <= WALK_LEFT;
                    end else if (!ground) begin
                        next_state <= FALL;
                    end else if (dig) begin
                        next_state <= DIG;
                    end else begin
                        next_state <= WALK_RIGHT;
                    end
                end
                
                FALL: begin
                    if (ground) begin
                        if (walk_right) begin
                            next_state <= WALK_RIGHT;
                        end else begin
                            next_state <= WALK_LEFT;
                        end
                    end else begin
                        next_state <= FALL;
                    end
                end
                
                DIG: begin
                    if (!ground) begin
                        next_state <= DIG_FALL;
                    end else begin
                        next_state <= DIG;
                    end
                end
                
                DIG_FALL: begin
                    if (ground) begin
                        if (walk_right) begin
                            next_state <= WALK_RIGHT;
                        end else begin
                            next_state <= WALK_LEFT;
                        end
                    end else begin
                        next_state <= DIG_FALL;
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        // Set outputs based on current state
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            
            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
            
            DIG: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
            
            DIG_FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 1;
            end
        endcase
    end
    
endmodule
