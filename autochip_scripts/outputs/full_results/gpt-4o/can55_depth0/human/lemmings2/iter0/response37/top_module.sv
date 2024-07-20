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
    typedef enum logic [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011
    } state_t;
    
    state_t state, next_state;
    
    // Synchronous state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic based on current state and inputs
    always_comb begin
        case (state)
            STATE_WALK_LEFT: begin
                if (~ground) begin
                    next_state = STATE_FALL_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            
            STATE_WALK_RIGHT: begin
                if (~ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            
            STATE_FALL_LEFT: begin
                if (ground) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_FALL_LEFT;
                end
            end
            
            STATE_FALL_RIGHT: begin
                if (ground) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_FALL_RIGHT;
                end
            end
            
            default: next_state = STATE_WALK_LEFT;
        endcase
    end
    
    // Output logic based on current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
        end else begin
            case (state)
                STATE_WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
                
                STATE_WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end
                
                STATE_FALL_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                
                STATE_FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                
                default: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
            endcase
        end
    end

endmodule
