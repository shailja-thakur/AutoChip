module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Defining state parameters
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // Register to hold the current state
    reg state, next_state;

    // Always block for state transition logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            default: next_state = WL; // Default state
        endcase
    end

    // Always block for updating state on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WL; // Reset state
        else 
            state <= next_state;
    end

    // Always block to set output signals based on the current state
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
            end
        endcase
    end

endmodule
