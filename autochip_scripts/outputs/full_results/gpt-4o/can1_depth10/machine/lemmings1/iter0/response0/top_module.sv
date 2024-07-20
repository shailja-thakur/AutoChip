module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Parameters representing the two states
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // Register to hold the current state
    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) next_state = WR;
                else next_state = WL;
            end
            WR: begin
                if (bump_right) next_state = WL;
                else next_state = WR;
            end
            default: next_state = WL; // Default state
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WL; // Reset to WL state
        else 
            state <= next_state;
    end

    // Output logic based on current state
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule
