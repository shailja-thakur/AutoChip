module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

// Define the states
parameter LEFT = 1'b0, RIGHT = 1'b1;

// Internal state variable
reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        // Reset the Lemming to walk left
        state <= LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
    end
    else begin
        case (state)
            LEFT: begin
                // Walking left
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                
                // Switching to walking right if bumped on the left
                if (bump_left) begin
                    state <= RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
            end
            RIGHT: begin
                // Walking right
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                
                // Switching to walking left if bumped on the right
                if (bump_right) begin
                    state <= LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
            end
            default: begin
                // This should never happen, but just in case
                state <= LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end
end

endmodule
