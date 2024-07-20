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
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground) 
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            
            WALK_RIGHT: begin
                if (!ground) 
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right) 
                    next_state = WALK_LEFT;
            end

            FALLING_LEFT: begin
                if (ground) 
                    next_state = WALK_LEFT;
            end
            
            FALLING_RIGHT: begin
                if (ground) 
                    next_state = WALK_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground) 
                    next_state = FALLING_LEFT;
            end

            DIG_RIGHT: begin
                if (!ground) 
                    next_state = FALLING_RIGHT;
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALLING_LEFT) || (state == FALLING_RIGHT);
        digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end

endmodule
