module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define the states
    typedef enum logic [1:0] {
        LEFT = 2'b01,
        RIGHT = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (combinational)
    always_comb begin
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
            default: next_state = LEFT; // default to one of the states to avoid latches
        endcase
    end
    
    // State update logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT; // Asynchronous reset to the LEFT state
        else
            state <= next_state;
    end
    
    // Output logic based on state (Moore machine)
    always_comb begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1; // default to walk left
                walk_right = 0;
            end
        endcase
    end

endmodule
