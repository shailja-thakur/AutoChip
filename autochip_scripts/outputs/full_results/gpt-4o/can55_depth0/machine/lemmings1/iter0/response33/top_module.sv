module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Parameter definitions for the states
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // Register to hold the current state
    reg state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) begin
                    next_state = WR;
                end else begin
                    next_state = WL;
                end
            end
            WR: begin
                if (bump_right) begin
                    next_state = WL;
                end else begin
                    next_state = WR;
                end
            end
            default: next_state = WL; // Default case to handle any unexpected states
        endcase
    end

    // Sequential logic to update the current state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL; // Reset to initial state
        end else begin
            state <= next_state; // Update state to the next state
        end
    end

    // Output logic based on the current state
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule
