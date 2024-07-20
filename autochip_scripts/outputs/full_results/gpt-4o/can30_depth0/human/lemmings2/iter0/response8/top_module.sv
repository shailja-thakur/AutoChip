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
    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic (comb. logic)
    always @(*) begin
        casex (state)
            WALK_LEFT: begin
                if (ground == 0) 
                    next_state = FALLING_LEFT;
                else if (bump_left) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (ground == 0) 
                    next_state = FALLING_RIGHT;
                else if (bump_right) 
                    next_state = WALK_LEFT;
                else 
                    next_state = WALK_RIGHT;
            end
            FALLING_LEFT: begin
                if (ground == 1) 
                    next_state = WALK_LEFT;
                else 
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground == 1) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = FALLING_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WALK_LEFT;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALLING_LEFT: aaah = 1;
            FALLING_RIGHT: aaah = 1;
        endcase
    end

endmodule
