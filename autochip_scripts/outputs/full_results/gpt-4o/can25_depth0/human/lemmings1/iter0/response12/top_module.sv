module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    typedef enum reg {LEFT, RIGHT} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) 
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right) 
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
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
    always @(state) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end
endmodule
