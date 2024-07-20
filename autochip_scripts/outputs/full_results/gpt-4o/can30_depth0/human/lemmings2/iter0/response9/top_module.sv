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
    // Define the state encoding
    typedef enum logic [1:0] {
        LEFT  = 2'b00,
        RIGHT = 2'b01,
        FALL  = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL;
                else if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) 
                    next_state = FALL;
                else if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL: begin
                if (ground)
                    next_state = (walk_left) ? LEFT : RIGHT;
                else
                    next_state = FALL;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        case(state)
            LEFT:   walk_left = 1'b1;
            RIGHT:  walk_right = 1'b1;
            FALL:   aaah = 1'b1;
        endcase
    end

endmodule
