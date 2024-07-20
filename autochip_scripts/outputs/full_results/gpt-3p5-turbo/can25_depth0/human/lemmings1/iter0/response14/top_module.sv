module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state enumeration
    typedef enum logic [1:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT
    } state_t;
    
    // Define internal state variable
    state_t curr_state, next_state;
    
    // Assign initial state
    initial begin
        curr_state = STATE_WALK_LEFT;
    end
    
    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            curr_state <= STATE_WALK_LEFT;
        end
        else begin
            curr_state <= next_state;
        end
    end
    
    // Combinational logic
    always @* begin
        case (curr_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                
                if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
                else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            
            STATE_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                
                if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        endcase
    end
endmodule
