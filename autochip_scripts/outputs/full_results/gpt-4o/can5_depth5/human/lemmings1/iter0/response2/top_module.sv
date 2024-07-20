module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state bits
    typedef enum reg {
        LEFT = 1'b0,   // State for walking left
        RIGHT = 1'b1   // State for walking right
    } state_t;
    
    // Current and next state variables
    reg state, next_state;

    // Combinational block to determine next state based on current state and inputs
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
        endcase
    end

    // Sequential block for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic based on state
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
    end
    
endmodule
